resource "aws_s3_bucket" "terraform-state" {
  bucket = "terraform-state-a2b6219-halovu"

  tags = {
    Name = "Terraform state"
  }
}
