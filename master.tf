resource "aws_launch_template" "jenkins_master_image" {
    name = "jenkins_master_image"
  image_id = "ami-084568db4383264d4" // Ubuntu Server 24.04 LTS
   tags = {
      Name = "jenkins_master_image"
    }
    instance_type = "t2.medium"
    user_data = base64encode(templatefile("${path.module}/jenkins-master-setup.tftpl", {
                jenkins_admin_password = var.jenkins_admin_password
            }
        ) 
    )
    block_device_mappings {
        device_name = "/dev/sda1"
        ebs {
            volume_size = var.master_volume_size
            volume_type = var.master_volume_type
        }
    }
    vpc_security_group_ids  = [aws_security_group.jenkins_master_sg.id]
    key_name = var.keypair_name
}

resource "aws_autoscaling_group" "master_asg" {
    name = "master_jenkins_asg"
    vpc_zone_identifier = [
        var.public_subnet
    ]
    availability_zones = [ "us-east-1a" ]
    min_size = 1
    max_size = 1
    launch_template {
      id = aws_launch_template.jenkins_master_image.id
    }
    depends_on = [ aws_launch_template.jenkins_master_image ]

}

data "aws_instance" "master_instance" {
    instance_tags = {
        "aws:autoscaling:groupName" = aws_autoscaling_group.master_asg.name
    }
}