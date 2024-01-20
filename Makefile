all: deps

hooks: pre-commit

deps: check_terraform_installed check_tflint_installed check_juju_status

check:
	@terraform fmt --recursive -check

format:
	@terraform fmt --recursive

check_terraform_installed:
	@which terraform 1>/dev/null 2>/dev/null || (echo "terraform not found, please install it (sudo snap install terraform)!"; exit 1)

check_tflint_installed:
	@which tflint 1>/dev/null 2>/dev/null || (echo "tflint not found, please install it (sudo snap install tflint)!"; exit 1)

check_juju_status:
	@juju status 1>/dev/null 2>/dev/null || (echo "terraform needs 'juju status' to run cleanly, return code was $$?"; exit 1)

pre-commit:
	@which pre-commit 1>/dev/null 2>&1 || sudo apt-get install -y pre-commit
	@pre-commit install 1>/dev/null

lint:
	@pre-commit run terraform_tflint --hook-stage manual --all-files

.PHONY: all deps check format hooks check_terraform_installed check_tflint_installed check_juju_status pre-commit tflint