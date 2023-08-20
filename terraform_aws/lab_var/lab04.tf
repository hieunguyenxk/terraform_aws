locals {
  lab04 = {
    s3 = {
      "s3-bucket" = {
        bucket_name = "hieunh40xk-bucket"
        suffix      = "index.html"
        error       = "error.html"
        acl         = "public-read"
      }
    }
  }
}