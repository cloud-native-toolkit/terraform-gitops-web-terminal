
resource null_resource write_outputs {
  provisioner "local-exec" {
    command = "echo \"$${OUTPUT}\" > gitops-output.json"

    environment = {
      OUTPUT = jsonencode({
        name        = module.web_terminal.name
        branch      = module.web_terminal.branch
        namespace   = module.web_terminal.namespace
        server_name = module.web_terminal.server_name
        layer       = module.web_terminal.layer
        layer_dir   = module.web_terminal.layer == "infrastructure" ? "1-infrastructure" : (module.web_terminal.layer == "services" ? "2-services" : "3-applications")
        type        = module.web_terminal.type
      })
    }
  }
}
