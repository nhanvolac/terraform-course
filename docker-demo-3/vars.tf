variable "AWS_REGION" {
  default = "eu-west-1"
}

variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "ECS_INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "ECS_AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-1924770e"
    us-west-2 = "ami-56ed4936"
    eu-west-1 = "ami-c8337dbb"
    ap-southeast-1 = "ami-0996cfb3acf118b24"
  }
}

# Full List: http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-01b996646377b6619"
    us-west-2 = "ami-0637e7dc7fcc9a2d9"
    eu-west-1 = "ami-081ff4b9aa4e81a08"
    ap-southeast-1 = "ami-0d3b2e26119a851ac"
    # ap-southeast-1 = "ami-0996cfb3acf118b24"
  }
}

variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}

variable "JENKINS_VERSION" {
  default = "2.319.2"
}
