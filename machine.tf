/*resource "aws_network_interface" "ext" {
    description       = "ext"
    subnet_id         = "subnet-84B9D0C1"
    source_dest_check = false
     attachment {
    instance     = aws_instance.ptaf.id
    device_index = 1
  }
}*/

variable "description" {
  default = "ptaf-4.0.4.2806-1166-71.qcow"

}


resource "aws_network_interface" "elastic" {
  subnet_id = "subnet-84B9D0C1"
  count = var.instance_count
  source_dest_check = false
  tags = {
           Name= "${var.description}_${count.index+1}"
    }
}

resource "aws_network_interface" "ad" {
  subnet_id = "sw-9111F52D"
  description = "MGMT"
  count = var.instance_count
  source_dest_check = false
/*     attachment {
    instance     = aws_instance.ptaf4.id
    device_index = 2
  }*/
  }

resource "aws_network_interface" "cluster" {
  subnet_id = "sw-BCD52B61"
  description = "eth-cluster"
  count = var.instance_count
  source_dest_check = false
/*     attachment {
    instance     = aws_instance.ptaf4.id
    device_index = 3
  }
*/  }

resource "aws_network_interface" "internal" {
  subnet_id = "sw-04BA4D61"
  description = "eth-int1"
  count = var.instance_count
  source_dest_check = false
/*     attachment {
    instance     = aws_instance.ptaf4.id
    device_index = 4
  }
*/   }

data "template_file" "user_data" {
  template = file("C:\\Users\\Ivan\\YandexDisk\\Работа\\PT\\terraform\\01-project\\data.yaml")
}

resource "aws_instance" "ptaf4" {
  count = var.instance_count
  ami = var.ptaf_node_id
  instance_type = var.ptaf_node_instance_type
  monitoring = true
  tags = {
           Name= "${var.description}_${count.index+1}"
    }
     network_interface {
      network_interface_id  = element(aws_network_interface.elastic.*.id,count.index)
      device_index  = 0
     }
     network_interface {
      network_interface_id  = element(aws_network_interface.ad.*.id,count.index)
      device_index = 1
     }
     network_interface {
      network_interface_id  = element(aws_network_interface.cluster.*.id,count.index)
       device_index  = 2
     }
     network_interface {
      network_interface_id  = element(aws_network_interface.internal.*.id,count.index)
       device_index  = 3
     }
     user_data  = data.template_file.user_data.rendered
/*    user_data = <<-EOF
                #cloud-config
                password: positive
                chpasswd: { expire: False }
                ssh_pwauth: True                
              EOF
  ebs_block_device {
          delete_on_termination = true
          #iops                  = 500
          encrypted             = false
          device_name           = "ebs_${var.description}_${count.index+1}"
          #volume_type           = "st2"
        }*/

}