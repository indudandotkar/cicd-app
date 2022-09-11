data "http" "myip"{
      url="http://ipv4.icanhazip.com"
 }

  resource "aws_security_group" "cicd" {
   name        = "allow_cicd"
   description = "allow cicd inbound traffic"
  vpc_id = "aws_vpc.vpc.id"

   
  ingress {
     description      = "ssh from admin"
     from_port        = 22
    to_port          = 22
     protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   }

ingress {
   description      = "connecting to end user"
   from_port        = 8080
   to_port          = 8080
   protocol         = "tcp"
     cidr_blocks      = [aws_vpc.main.cidr_block]
  }




  egress {
    from_port        = 0
     to_port          = 0
    protocol         = "-1"
   cidr_blocks      = ["0.0.0.0/0"]
     ipv6_cidr_blocks = ["::/0"]
  }

 tags = {
  Name = "cicd"
   }
 }



 resource "aws_instance" "cicd" {
   ami           = "ami-0568773882d492fc8"
  vpc_id      = "aws_vpc.vpc.id"
   instance_type = "t2.micro"
  subnet_id=aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.bastion.id]

   tags = {
     Name = "cicd"
   }
 }