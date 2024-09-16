resource "aws_lambda_function" "lambda" {
  function_name    = "MyLambdaFunction"
  s3_bucket        = var.s3_bucket
  s3_key           = var.s3_key
  handler          = "lambda-code.lambda_handler"
  runtime          = "python3.9"
  role             = aws_iam_role.lambda_exec_role.arn
  #source_code_hash = filebase64sha256(var.s3_zip_file)

  environment {
    variables = {
      ENV_VAR = "Value"
    }
  }
}

resource "aws_iam_role" "lambda_exec_role" {
  name               = "lambda_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [ {
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
    } ],
  })

  inline_policy {
    name   = "lambda_policy"
    policy = jsonencode({
      Version = "2012-10-17",
      Statement = [
        {
          Action   = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ],
          Effect   = "Allow",
          Resource = "*"
        },
        {
          Action   = "s3:GetObject",
          Effect   = "Allow",
          Resource = "arn:aws:s3:::${var.s3_bucket}/*"
        }
      ]
    })
  }
}
