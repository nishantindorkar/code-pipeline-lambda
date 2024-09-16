# resource "aws_s3_bucket" "lambda_bucket" {
#   bucket = "lambdapycodebuck"
# }

resource "aws_s3_bucket" "pipeline_artifact_bucket" {
  bucket = "lambda-py-code-buck-artifact"
}
