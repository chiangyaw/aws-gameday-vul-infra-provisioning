resource "aws_s3_bucket" "gameday_s3_bucket"{
    bucket_prefix = "sensitive-data"
    tags = {
        Name = "Sensitive Data S3"
        Environment = "Prod"
    }
}

resource "aws_s3_object" "sensitive_data_s3_object" {
  key    = "sensitive-data-s3-object"
  bucket = aws_s3_bucket.gameday_s3_bucket.id
  source = "1-MB-Test-SensitiveData.xlsx"
}