# Docker Terraform TFLint

Docker image for using both [Terraform](https://github.com/hashicorp/terraform) and [TFLint](https://github.com/wata727/tflint) -- perfect if you're using modules (and need to run `$ terraform get` before you lint).

### Usage

```shell
docker run --rm -v TERRAFORM_SOURCE_PATH:/usr/src:ro charliekenney23/docker-terraform-tflint 
```
