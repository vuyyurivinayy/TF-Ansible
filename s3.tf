resource "aws_s3_bucket" "one" {
  bucket = "vinay.devops.project.buckets"
}

resource "aws_s3_bucket_ownership_controls" "two" {
  bucket = aws_s3_bucket.one.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "three" {
  depends_on = [aws_s3_bucket_ownership_controls.two]

  bucket = aws_s3_bucket.one.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "three" {
bucket = aws_s3_bucket.one.id
versioning_configuration {
status = "Enabled"
}
}

terraform {
  backend "s3" {
    bucket = "vinay.devops.project.buckets"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
  }
}


