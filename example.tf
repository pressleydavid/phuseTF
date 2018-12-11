provider "aws" {
  access_key = "AKIAIOTDIMAKCWQFRD7Q"
  secret_key = "dfw7TGxfN+h4tv0X5eJ7rzkzZfvBIx0tZjThptT+"
  region     = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-b374d5a5"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.example.id}"
}

module "child" {
  source = "./child"

  memory = "4G"
}

output "child_memory" {
  value = "${module.child.received}"
}
