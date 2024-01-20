locals {
  http_proxy  = output.env.result["http_proxy"] == "" ? var.http_proxy : output.env.result["http_proxy"]
  https_proxy = output.env.result["https_proxy"] == "" ? var.https_proxy : output.env.result["https_proxy"]
  no_proxy    = output.env.result["hostname"] == "" ? var.no_proxy : join(", ", [var.no_proxy, output.env.result["hostname"]])
}