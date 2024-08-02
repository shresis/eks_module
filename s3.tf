resource "aws_s3_bucket" "remote-state" {
    bucket = "terraform-state-file-26072024"
    force_destroy = true 
}

resource "aws_s3_bucket_versioning" "s3-versioning" {
    bucket = aws_s3_bucket.remote-state.id
    versioning_configuration {
      status = "Enabled"
    }
}

resource "aws_dynamodb_table" "remote-statelock" {
    name = "dynamodb-statelock"
    billing_mode = "PROVISIONED"
    read_capacity = 20
    write_capacity = 20
    hash_key = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }
}
