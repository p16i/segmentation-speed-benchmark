provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "tokenization_speed_benchmark" {
  ami = "ami-04f2719aea9710d47" # dl ami Linux 2 v.29
  instance_type = "p2.xlarge"
  #instance_type = "t2.medium"

  vpc_security_group_ids = ["sg-4c325e28"]
  subnet_id              = "subnet-3606d053"
  key_name               = "id_rsa_aws"

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y git tmux htop",
      "pip3 install --user tensorflow deepcut pythainlp fire ssg --no-cache-dir > /dev/null",
      "git clone https://github.com/sertiscorp/thai-word-segmentation.git",
      "wget https://gist.github.com/heytitle/9d195fc96a79c2ba4a4c5a70964c7cd0/raw/404b05d3ea3d90aa68231d41003ea44142e32b01/wisesight160.txt -O wisesight160.txt",
      "wget https://gist.github.com/heytitle/696e908a0d59850e1374c5f823010e3d/raw/02744055414c748e143ca2d862997e59f25a9bcf/gistfile1.txt -O best-val.txt",
      "wget https://github.com/PyThaiNLP/wisesight-sentiment/blob/master/kaggle-competition/train.txt?raw=true -O wisesight.txt",
      "wget https://gist.githubusercontent.com/heytitle/6bbfbb43f0a586d9eef4d785ba466e00/raw/d6d3df2c0cd0605969c480a4188ae7e0c9256835/gistfile1.txt -O best-test.txt"
    ]
  }

  provisioner "file" {
    source      = "scripts"
    destination = "scripts"
  }

  connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = "${file("~/.ssh/id_rsa_aws.pem")}"
      host = "${aws_instance.tokenization_speed_benchmark.public_ip}"
  }
}
output "instance_ip" {
  value = "${aws_instance.tokenization_speed_benchmark.public_ip}"
}