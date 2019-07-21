provider "aws" {
  region = "ap-southeast-1"
}

variable "instance_type" {
  type = string
}

resource "aws_instance" "tokenization_speed_benchmark" {
  ami = "ami-0a293956a1c3d84f4" # dl ami
  # instance_type = "t2.small"
  instance_type = var.instance_type

  vpc_security_group_ids = ["sg-4c325e28"]
  subnet_id              = "subnet-3606d053"
  key_name               = "id_aws_rsa"

  provisioner "remote-exec" {
    inline = [
      # "sudo yum update -y",
      # "sudo yum install -y make glibc-devel gcc gcc-c++ patch mosh python36 python36-devel git tmux htop",
      "sudo yum install -y mosh git tmux htop",
      # "sudo easy_install-3.6 pip",
      "pip3 install --user tensorflow deepcut pythainlp fire https://github.com/ponrawee/ssg/archive/master.zip --no-cache-dir > /dev/null",
      "git clone https://github.com/sertiscorp/thai-word-segmentation.git",
      # slimcut
      "wget https://gist.github.com/heytitle/9d195fc96a79c2ba4a4c5a70964c7cd0/raw/404b05d3ea3d90aa68231d41003ea44142e32b01/wisesight160.txt -O wisesight160.txt",
      "wget https://gist.github.com/heytitle/696e908a0d59850e1374c5f823010e3d/raw/02744055414c748e143ca2d862997e59f25a9bcf/gistfile1.txt -O best-val.txt",
      "wget https://github.com/PyThaiNLP/wisesight-sentiment/blob/master/kaggle-competition/train.txt?raw=true -O wisesight.txt",
      "mosh-server"
    ]
  }

  provisioner "file" {
    source      = "scripts"
    destination = "scripts"
  }
    connection {
        type     = "ssh"
        user     = "ec2-user"
        private_key = "${file("~/.ssh/id_aws_rsa")}"
        host = "${aws_instance.tokenization_speed_benchmark.public_ip}"
    }
}
output "instance_ip" {
  value = "${aws_instance.tokenization_speed_benchmark.public_ip}"
}