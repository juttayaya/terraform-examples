module "default-tags-dynamodb-add" {
  source = "./tfmodules/default-tags-dynamodb-add"

  tags = {
    module-project = "default-tags-module-add"
  }
}
