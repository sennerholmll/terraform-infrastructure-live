terragrunt {
  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
  terraform = {
    source = "git@github.com:sennerholm/terraform-infrastructure-modules.git//gocd-agent?ref=a88641b7575058ec5ac3e7d6080e3254311e6048"
    extra_arguments "conditional_vars" {
      commands = ["${get_terraform_commands_that_need_vars()}"]

      required_var_files = [
        "${get_tfvars_dir()}/terraform.tfvars",

      ]

      optional_var_files = [
        "${get_tfvars_dir()}/../../region.tfvars",
        "${get_tfvars_dir()}/../environment.tfvars"
      ]
    }
    extra_arguments "terragrunt_config_path" {
      commands = ["${get_terraform_commands_that_need_vars()}"]
      arguments = [
        "-var", "terragrunt_config_path=${get_tfvars_dir()}/terragrunt_in_pod"
      ]  
    }
  }
  dependencies {
    paths = ["../gke","../gocd-server"]
  }
}