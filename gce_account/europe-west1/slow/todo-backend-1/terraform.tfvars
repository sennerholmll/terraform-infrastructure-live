terragrunt {
  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
  terraform = {
    source = "github.com/sennerholm/node-todo-backend.git//terraform/todo-backend?ref=d0d0cbe35d4ea73cb48bff77f062158e7d2d3b4e"
    extra_arguments "conditional_vars" {
      commands = ["${get_terraform_commands_that_need_vars()}"]

      required_var_files = [
        "${get_tfvars_dir()}/terraform.tfvars",

      ]

      optional_var_files = [
        "${get_tfvars_dir()}/../../region.tfvars",
        "${get_tfvars_dir()}/../environment.tfvars",
        "${get_tfvars_dir()}/version.tfvars"
      ]
    }
  }
  dependencies {
    paths = ["../../prod/gke"]
  }
}

mode = "pod"
namespace_suffix = "1"
