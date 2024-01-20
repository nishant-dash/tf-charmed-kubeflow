import yaml
import json

# procs
import requests

# formatting stuff
from rich.console import Console

# global declarations
console = Console()
HTTP_OK = 200
KF_SOURCE = "https://github.com/canonical/bundle-kubeflow"


TEMPLATE_APPLICATION = """
resource "juju_application" "{app_name}" {{
  name  = "{app_name}"
  model = var.juju_model_name
  trust = {trust}

  charm {{
    name    = "{charm}"
    channel = var.{channel_var}_channel
  }}

  units     = {scale}

  depends_on = [
    juju_model.kubeflow
  ]
}}"""

TEMPLATE_APPLICATION_WITH_CONFIG = """
resource "juju_application" "{app_name}" {{
  name  = "{app_name}"
  model = var.juju_model_name
  trust = {trust}

  charm {{
    name    = "{charm}"
    channel = var.{channel_var}_channel
  }}

  units     = {scale}

  config = {{
    {config}
  }}

  depends_on = [
    juju_model.kubeflow
  ]
}}"""

TEMPLATE_INTEGRATION = """
resource "juju_integration" "{charm1}-{charm2}-{endpoint}" {{
  model = var.juju_model_name

  application {{
    name     = juju_application.{charm1}.name
    endpoint = "{charm1_endpoint}"
  }}

  application {{
    name     = juju_application.{charm2}.name
    endpoint = "{charm2_endpoint}"
  }}
}}"""

TEMPLATE_INTEGRATION_NO_ENDPOINTS = """
resource "juju_integration" "{charm1}-{charm2}" {{
  model = var.juju_model_name

  application {{
    name     = juju_application.{charm1}.name
  }}

  application {{
    name     = juju_application.{charm2}.name
  }}
}}"""


TEMPLATE_VERSION = """
variable "{app_name}_channel" {{
  description = "Charm channel of {charm}"
  type        = string
  default     = "{channel}"
}}"""


def download_bundle(channel_string: str = None) -> {}:
    """
    Given a channel, download the bundle yaml from Charmed Kubeflow's github
    and return the yaml as a dictionary

    Returns:
    - Dictionary format of the remote yaml file
    """
    if not channel_string:
        # console.print("Unable to get version")
        return None
    target_bundle = None
    version, channel = channel_string.split("/")
    if version == "latest":
        url = f"{KF_SOURCE}/raw/main/releases/{version}/{channel}/bundle.yaml"
    else:
        url = f"{KF_SOURCE}/raw/main/releases/{version}/{channel}/kubeflow/bundle.yaml"
    response = requests.get(url)
    # console.print(f"Downloading kf {channel_string} bundle...")
    if response.status_code != HTTP_OK:
        response.raise_for_status()
        console.print_exception(
            f"Target bundle for Kubeflow {channel_string} not found!"
        )
    else:
        try:
            target_bundle = yaml.safe_load(response.content)
        except yaml.YAMLError as error:
            console.print(error)

    return target_bundle


def generate_versions(bundle: dict = {}):
    for app, info in bundle["applications"].items():
        params = {
            "app_name": app.replace("-", "_"),
            "charm": info["charm"],
            "channel": info["channel"],
        }
        console.print(TEMPLATE_VERSION.format(**params))


def render_config(config: dict = {}):
    config_string = ""
    for k, v in config.items():
        config_string += f'{k} = "{v}"' + "\n"
    return config_string[:-1]


def generate_applications_tf(applications):
    for app, info in applications.items():
        # x = info["options"] if "options" in info else ""
        charm_config = render_config(info["options"]) if "options" in info else ""
        params = {
            "app_name": app,
            "charm": info["charm"],
            "trust": str(info["trust"]).lower() if "trust" in info else "false",
            "channel_var": app.replace("-", "_"),
            "scale": info["scale"],
        }
        template = TEMPLATE_APPLICATION
        if charm_config:
            params["config"] = charm_config
            template = TEMPLATE_APPLICATION_WITH_CONFIG
        console.print(template.format(**params))


def generate_integrations_tf(relations):
    for relation in relations:
        if ":" in relation[0]:
            charm1, endpoint1 = relation[0].split(":")
            charm2, endpoint2 = relation[1].split(":")
            params = {
                "charm1": charm1,
                "charm2": charm2,
                "charm1_endpoint": endpoint1,
                "charm2_endpoint": endpoint2,
                "endpoint": endpoint1
                if endpoint1 == endpoint2
                else endpoint1 + endpoint2,
            }
            template = TEMPLATE_INTEGRATION
        else:
            params = {
                "charm1": relation[0],
                "charm2": relation[1],
            }
            template = TEMPLATE_INTEGRATION_NO_ENDPOINTS
        console.print(template.format(**params))


def generate_main(bundle: dict = {}):
    generate_applications_tf(bundle["applications"])
    generate_integrations_tf(bundle["relations"])


if __name__ == "__main__":
    bundle = download_bundle("1.8/stable")
    # generate_versions(bundle)
    generate_main(bundle)
