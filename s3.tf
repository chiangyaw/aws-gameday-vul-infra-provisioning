resource "aws_s3_bucket" "gameday_s3_bucket"{
    bucket_prefix = "sensitive-data"
    tags = {
        Name = "Sensitive Data S3"
        Environment = "Prod"
    }
}