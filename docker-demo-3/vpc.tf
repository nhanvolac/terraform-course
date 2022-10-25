# Internet VPC
resource "aws_vpc" "STG" {
  cidr_block           = "172.20.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "STG"
  }
}

# Internet VPC
resource "aws_vpc" "DEV" {
  cidr_block           = "172.31.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  //enable_classiclink   = "false"
  tags = {
    Name = "DEV"
  }
}

# Subnets
resource "aws_subnet" "STG-public-1" {
  vpc_id                  = aws_vpc.STG.id
  cidr_block              = "172.20.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "STG-public-net-1a"
  }
}

resource "aws_subnet" "STG-public-2" {
  vpc_id                  = aws_vpc.STG.id
  cidr_block              = "172.20.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-southeast-1b"

  tags = {
    Name = "STG-public-net-1b"
  }
}

resource "aws_subnet" "STG-private-1" {
  vpc_id                  = aws_vpc.STG.id
  cidr_block              = "172.20.2.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "STG-private-net-1a"
  }
}

resource "aws_subnet" "STG-private-2" {
  vpc_id                  = aws_vpc.STG.id
  cidr_block              = "172.20.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-southeast-1b"

  tags = {
    Name = "STG-private-net-1b"
  }
}

resource "aws_subnet" "DEV-public-1" {
  vpc_id                  = aws_vpc.DEV.id
  cidr_block              = "172.31.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "DEV-public-net-1a"
  }
}

resource "aws_subnet" "DEV-public-2" {
  vpc_id                  = aws_vpc.DEV.id
  cidr_block              = "172.31.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-southeast-1b"

  tags = {
    Name = "DEV-public-net-1b"
  }
}

resource "aws_subnet" "DEV-private-1" {
  vpc_id                  = aws_vpc.DEV.id
  cidr_block              = "172.31.2.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "DEV-private-net-1a"
  }
}

resource "aws_subnet" "DEV-private-2" {
  vpc_id                  = aws_vpc.DEV.id
  cidr_block              = "172.31.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-southeast-1b"

  tags = {
    Name = "DEV-private-net-1b"
  }
}


# Internet GW
resource "aws_internet_gateway" "stg-main-gw" {
  vpc_id = aws_vpc.STG.id

  tags = {
    Name = "STG | Internet GW"
  }
}

resource "aws_internet_gateway" "dev-main-gw" {
  vpc_id = aws_vpc.DEV.id

  tags = {
    Name = "DEV | Internet GW"
  }
}

# route tables STG public
resource "aws_route_table" "stg-rt-public" {
  vpc_id = aws_vpc.STG.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.stg-main-gw.id
  }

  tags = {
    Name = "RTB | STG-public"
  }
}

# route tables DEV public
resource "aws_route_table" "dev-rt-public" {
  vpc_id = aws_vpc.DEV.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-main-gw.id
  }

  tags = {
    Name = "RTB | DEV public"
  }
}

# route associations STG public
resource "aws_route_table_association" "stg-public-1-a" {
  subnet_id      = aws_subnet.STG-public-1.id
  route_table_id = aws_route_table.stg-rt-public.id
}

resource "aws_route_table_association" "stg-public-2-a" {
  subnet_id      = aws_subnet.STG-public-2.id
  route_table_id = aws_route_table.stg-rt-public.id
}


# route associations DEV public
resource "aws_route_table_association" "dev-public-1-a" {
  subnet_id      = aws_subnet.DEV-public-1.id
  route_table_id = aws_route_table.dev-rt-public.id
}

resource "aws_route_table_association" "dev-public-2-a" {
  subnet_id      = aws_subnet.DEV-public-2.id
  route_table_id = aws_route_table.dev-rt-public.id
}
