variable "s3_bucket" {
  description = "The name of the S3 bucket where the Lambda code is stored."
  type        = string  
  default = "lambdapycodebuck"
}

variable "s3_key" {
  description = "The S3 object key for the Lambda code."
  type        = string
  default = "lambda-code.zip"
}

variable "s3_zip_file" {
  default = "lambda-code.zip"
}
