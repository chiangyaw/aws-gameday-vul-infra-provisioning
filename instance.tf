data "aws_ami" "aws_ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

resource "aws_instance" "ubuntu_instance_a" {
  ami                         = data.aws_ami.aws_ubuntu.id
  instance_type               = "t2.medium"
  subnet_id                   = aws_subnet.gameday_sub_a.id
  key_name                    = "keypair"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.gameday_sg_1.id]
  iam_instance_profile = aws_iam_instance_profile.gameday_profile_a.name
  root_block_device{
      volume_size = 100
      volume_type = "gp2"
    }

  user_data = <<-BOOTSTRAP
#!/bin/bash
echo "Executing Bootstrap Script..." >> /var/log/aws-gameday-cloud-init.log
sudo apt update -y && apt upgrade -y >> /var/log/aws-gameday-cloud-init.log
sudo apt install -y openjdk-11-jdk wget unzip >> /var/log/aws-gameday-cloud-init.log
cd /tmp
sudo wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.73/bin/apache-tomcat-8.5.73.tar.gz >> /var/log/aws-gameday-cloud-init.log
sudo tar -xzf apache-tomcat-8.5.73.tar.gz
sudo mv apache-tomcat-8.5.73 /opt/tomcat
sudo wget https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.14.1/log4j-core-2.14.1.jar -P /opt/tomcat/lib/ >> /var/log/aws-gameday-cloud-init.log
sudo wget https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-api/2.14.1/log4j-api-2.14.1.jar -P /opt/tomcat/lib/ >> /var/log/aws-gameday-cloud-init.log
echo "Writing to war file..." >> /var/log/aws-gameday-cloud-init.log
sudo cat <<EOF > /opt/tomcat/webapps/vulnerable-log4j-app.war
<!DOCTYPE html>
<html>
<body>
<h1>Gameday App</h1>
<form action="/log4j" method="post">
    Enter data: <input type="text" name="data">
    <button type="submit">Submit</button>
</form>
</body>
</html>
EOF

echo "Executing tomcat startup script..." >> /var/log/aws-gameday-cloud-init.log
sudo chmod +x /opt/tomcat/bin/*.sh
sudo /opt/tomcat/bin/startup.sh

echo "Writing to tomcat service file..." >> /var/log/aws-gameday-cloud-init.log
sudo cat <<EOF > /etc/systemd/system/tomcat.service
[Unit]
Description=Apache Tomcat
After=network.target

[Service]
Type=forking
ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh
User=root
Group=root

[Install]
WantedBy=multi-user.target
EOF

echo "Updating and restarting daemon-reload and tomcat services" >> /var/log/aws-gameday-cloud-init.log
sudo systemctl daemon-reload
sudo systemctl enable tomcat
sudo systemctl start tomcat
echo "Bootstrap completed" >> /var/log/aws-gameday-cloud-init.log
BOOTSTRAP

  tags = {
    Name   = "frontend-app"
  }
}


resource "aws_instance" "ubuntu_instance_b" {
  ami                         = data.aws_ami.aws_ubuntu.id
  instance_type               = "t2.medium"
  subnet_id                   = aws_subnet.gameday_sub_a.id
  key_name                    = "keypair"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.gameday_sg_1.id]
  root_block_device{
      volume_size = 100
      volume_type = "gp2"
    }

  user_data = var.log4j_user_data

  tags = {
    Name   = "frontend-app"
  }
}

resource "aws_instance" "ubuntu_instance_c" {
  ami                         = data.aws_ami.aws_ubuntu.id
  instance_type               = "t2.medium"
  subnet_id                   = aws_subnet.gameday_sub_a.id
  key_name                    = "keypair"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.gameday_sg_1.id]
  iam_instance_profile = aws_iam_instance_profile.gameday_profile_a.name
  root_block_device{
      volume_size = 100
      volume_type = "gp2"
    }
  metadata_options {
    http_tokens = "required"
  }

  user_data = var.log4j_user_data

  tags = {
    Name   = "frontend-app"
  }
}

resource "aws_instance" "ubuntu_instance_d" {
  ami                         = data.aws_ami.aws_ubuntu.id
  instance_type               = "t2.medium"
  subnet_id                   = aws_subnet.gameday_sub_b.id
  key_name                    = "keypair"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.gameday_sg_1.id]
  iam_instance_profile = aws_iam_instance_profile.gameday_profile_a.name
  root_block_device{
      volume_size = 100
      volume_type = "gp2"
    }

  user_data = var.log4j_user_data

  tags = {
    Name   = "frontend-app"
  }
}

resource "aws_instance" "ubuntu_instance_e" {
  ami                         = data.aws_ami.aws_ubuntu.id
  instance_type               = "t2.medium"
  subnet_id                   = aws_subnet.gameday_sub_b.id
  key_name                    = "keypair"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.gameday_sg_1.id]
  root_block_device{
      volume_size = 100
      volume_type = "gp2"
    }
  metadata_options {
    http_tokens = "required"
  }

  user_data = var.log4j_user_data

  tags = {
    Name   = "frontend-app"
  }
}

resource "aws_instance" "ubuntu_instance_f" {
  ami                         = data.aws_ami.aws_ubuntu.id
  instance_type               = "t2.medium"
  subnet_id                   = aws_subnet.gameday_sub_a.id
  key_name                    = "keypair"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.gameday_sg_1.id]
  iam_instance_profile = aws_iam_instance_profile.gameday_profile_a.name
  root_block_device{
      volume_size = 100
      volume_type = "gp2"
    }
  metadata_options {
    http_tokens = "required"
  }

  # user_data = var.log4j_user_data

  tags = {
    Name   = "frontend-app"
  }
}

resource "aws_instance" "ubuntu_instance_g" {
  ami                         = data.aws_ami.aws_ubuntu.id
  instance_type               = "t2.medium"
  subnet_id                   = aws_subnet.gameday_sub_b.id
  key_name                    = "keypair"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.gameday_sg_1.id]
  root_block_device{
      volume_size = 100
      volume_type = "gp2"
    }

  # user_data = var.user_data

  tags = {
    Name   = "frontend-app"
  }
}

resource "aws_instance" "ubuntu_instance_pcs_a" {
  ami                         = data.aws_ami.aws_ubuntu.id
  instance_type               = "t2.medium"
  subnet_id                   = aws_subnet.gameday_sub_a.id
  key_name                    = "keypair"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.gameday_sg_2.id]
  iam_instance_profile = aws_iam_instance_profile.gameday_profile_a.name
  root_block_device{
      volume_size = 100
      volume_type = "gp2"
    }

  user_data = <<-BOOTSTRAP
#!/bin/bash
echo "Executing Bootstrap Script..." >> /var/log/aws-gameday-cloud-init.log
sudo apt update -y && apt upgrade -y >> /var/log/aws-gameday-cloud-init.log
sudo apt install -y openjdk-11-jdk wget unzip >> /var/log/aws-gameday-cloud-init.log
cd /tmp
sudo wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.73/bin/apache-tomcat-8.5.73.tar.gz >> /var/log/aws-gameday-cloud-init.log
sudo tar -xzf apache-tomcat-8.5.73.tar.gz
sudo mv apache-tomcat-8.5.73 /opt/tomcat
sudo wget https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.14.1/log4j-core-2.14.1.jar -P /opt/tomcat/lib/ >> /var/log/aws-gameday-cloud-init.log
sudo wget https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-api/2.14.1/log4j-api-2.14.1.jar -P /opt/tomcat/lib/ >> /var/log/aws-gameday-cloud-init.log
echo "Writing to war file..." >> /var/log/aws-gameday-cloud-init.log
sudo cat <<EOF > /opt/tomcat/webapps/vulnerable-log4j-app.war
<!DOCTYPE html>
<html>
<body>
<h1>Gameday App</h1>
<form action="/log4j" method="post">
    Enter data: <input type="text" name="data">
    <button type="submit">Submit</button>
</form>
</body>
</html>
EOF

echo "Executing tomcat startup script..." >> /var/log/aws-gameday-cloud-init.log
sudo chmod +x /opt/tomcat/bin/*.sh
sudo /opt/tomcat/bin/startup.sh

echo "Writing to tomcat service file..." >> /var/log/aws-gameday-cloud-init.log
sudo cat <<EOF > /etc/systemd/system/tomcat.service
[Unit]
Description=Apache Tomcat
After=network.target

[Service]
Type=forking
ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh
User=root
Group=root

[Install]
WantedBy=multi-user.target
EOF

echo "Updating and restarting daemon-reload and tomcat services" >> /var/log/aws-gameday-cloud-init.log
sudo systemctl daemon-reload
sudo systemctl enable tomcat
sudo systemctl start tomcat
echo "Bootstrap completed" >> /var/log/aws-gameday-cloud-init.log
BOOTSTRAP

  tags = {
    Name   = "backend-app"
  }
}


resource "aws_instance" "ubuntu_instance_pcs_b" {
  ami                         = data.aws_ami.aws_ubuntu.id
  instance_type               = "t2.medium"
  subnet_id                   = aws_subnet.gameday_sub_a.id
  key_name                    = "keypair"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.gameday_sg_2.id]
  root_block_device{
      volume_size = 100
      volume_type = "gp2"
    }

  user_data = var.log4j_user_data

  tags = {
    Name   = "frontend-app"
  }
}

resource "aws_instance" "ubuntu_instance_pcs_c" {
  ami                         = data.aws_ami.aws_ubuntu.id
  instance_type               = "t2.medium"
  subnet_id                   = aws_subnet.gameday_sub_a.id
  key_name                    = "keypair"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.gameday_sg_2.id]
  iam_instance_profile = aws_iam_instance_profile.gameday_profile_a.name
  root_block_device{
      volume_size = 100
      volume_type = "gp2"
    }
  metadata_options {
    http_tokens = "required"
  }

  user_data = var.log4j_user_data

  tags = {
    Name   = "backend-app"
  }
}

resource "aws_instance" "ubuntu_instance_pcs_d" {
  ami                         = data.aws_ami.aws_ubuntu.id
  instance_type               = "t2.medium"
  subnet_id                   = aws_subnet.gameday_sub_b.id
  key_name                    = "keypair"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.gameday_sg_2.id]
  iam_instance_profile = aws_iam_instance_profile.gameday_profile_a.name
  root_block_device{
      volume_size = 100
      volume_type = "gp2"
    }

  user_data = var.log4j_user_data

  tags = {
    Name   = "backend-app"
  }
}

resource "aws_instance" "ubuntu_instance_pcs_e" {
  ami                         = data.aws_ami.aws_ubuntu.id
  instance_type               = "t2.medium"
  subnet_id                   = aws_subnet.gameday_sub_b.id
  key_name                    = "keypair"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.gameday_sg_2.id]
  root_block_device{
      volume_size = 100
      volume_type = "gp2"
    }
  metadata_options {
    http_tokens = "required"
  }

  user_data = var.log4j_user_data

  tags = {
    Name   = "backend-app"
  }
}

resource "aws_instance" "ubuntu_instance_pcs_f" {
  ami                         = data.aws_ami.aws_ubuntu.id
  instance_type               = "t2.medium"
  subnet_id                   = aws_subnet.gameday_sub_a.id
  key_name                    = "keypair"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.gameday_sg_2.id]
  iam_instance_profile = aws_iam_instance_profile.gameday_profile_a.name
  root_block_device{
      volume_size = 100
      volume_type = "gp2"
    }
  metadata_options {
    http_tokens = "required"
  }

  # user_data = var.log4j_user_data

  tags = {
    Name   = "backend-app"
  }
}

resource "aws_instance" "ubuntu_instance_pcs_g" {
  ami                         = data.aws_ami.aws_ubuntu.id
  instance_type               = "t2.medium"
  subnet_id                   = aws_subnet.gameday_sub_b.id
  key_name                    = "keypair"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.gameday_sg_2.id]
  root_block_device{
      volume_size = 100
      volume_type = "gp2"
    }

  # user_data = var.user_data

  tags = {
    Name   = "backend-app"
  }
}

