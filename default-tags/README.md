## Best Practice for Terraform AWS Tags

AWS tags are important for categorizing billing and usage. Starting with AWS provider v3.38.0
and Terraform 0.12.31, Hashicorp added the default tags feature to configure AWS tags in one place
and automatically apply it to all AWS resources.

Please see [Github] for full Terraform code

### Basic Usage

The default tags are defined in the AWS provider section and it will automatically be applied
to all AWS resources

```terraform
provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
	  app        = "Rocket Insights"	
      created_by = "terraform"
      project    = "Project A"
    }
  }
}
resource "aws_dynamodb_table" "default-tags-basic" {
  name     = "default-tags-basic"
  ............
}

``` 
The final tags for aws_dynamodb_table.default-tags-basic are

```
"app"         = "Rocket Insights"
"created_by"  = "terraform"
"project"     = "Project A"
```

### Add and Override default tags
If an AWS resource requires more tags in addition to the default tags, simply add the tag to the
built-in resource `tags` block.

If an AWS resource requires to override a default tag, simply define a tag with the same key in the `tag`
block

```terraform
resource "aws_dynamodb_table" "default-tags-add" {
  name     = "default-tags-add"
  .......
  
  tags = {
    project     = "Project Override"
    sub-project = "Subproject Add"
  }
}

```  
The final tags for aws_dynamodb_table.default-tags-add are

```
"app"         = "Rocket Insights"
"created_by"  = "terraform"
"project"     = "Project Override"
"sub-project" = "Subproject Add"
```

### Alternate Default Tags
If an AWS resource requires alternate default tags, an alternate AWS provider with new default tags can be defined

```terraform
provider "aws" {
  alias  = "alt-tags"
  region = "us-east-1"
  default_tags {
    tags = {
      modified   = "Terraform"
      owner      = "Owner B"
    }
  }
}

resource "aws_dynamodb_table" "default-tags-alternate" {
  provider = aws.alt-tags
  name     = "default-tags-alternate"
  ........
}
```
The final tags for aws_dynamodb_table.default-tags-alternate are
```
"modified"   = "Terraform"
"owner"      = "Owner B"
```

### Modules and Default Tags
The AWS default tags apply to existing Terraform AWS modules without any changes needed

```terraform
module "default-tags-dynamodb" {
  source = "./tfmodules/default-tags-dynamodb"
}
```
The final tags for module.default-tags-dynamodb.aws_dynamodb_table.default-tags-module are
```
"app"         = "Rocket Insights"
"created_by"  = "terraform"
"project"     = "Project A"
```

### Add and Override default tags
If an AWS module requires more tags in addition to the default tags, simply define the module tags 
variable and add the tag to the module

```terraform
module "default-tags-dynamodb-add" {
  source = "./tfmodules/default-tags-dynamodb-add"

  tags = {
    module-project = "default-tags-module-add"
  }
}
```
The final tags for module.default-tags-dynamodb-add.aws_dynamodb_table.default-tags-module-add are
```
"app"            = "Rocket Insights"
"created_by"     = "terraform"
"module-project" = "default-tags-module-add"
"project"        = "Project A"
```

### Modules and Alternate Tags
If an AWS module requires alternate default tags, an alternate AWS provider with new default tags can be defined
and the new provider can be passed to module

```terraform
module "default-tags-dynamodb-alternate" {
  source = "./tfmodules/default-tags-dynamodb"
  providers = {
    aws = aws.alt-tags
  }
  ........
}
```
The final tags for module.default-tags-dynamodb-alternate.aws_dynamodb_table.default-tags-module are
```
"modified" = "Terraform"
"owner"    = "Owner B"
```
### Modules with both Default and Alternate Tags
If an AWS module requires both the default and alternate default tags, the default and alternate AWS providers can be defined
and the both providers can be passed to module. Then the module can assign which AWS resource uses which AWS provider

```terraform
module "default-and-alternate-tags-dynamodb" {
  source = "./tfmodules/default-and-alternate-tags-dynamodb"
  providers = {
    aws          = aws
    aws.alt-tags = aws.alt-tags
  }
}
```
The final tags for the two DynamoDB resources in the default-and-alternate-tags-dynamod TF modules
will use the asssigned AWS provider


