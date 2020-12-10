output "ip" {
    #value = join(",", aws_instance.ptaf4.*.public_ip)
    value = aws_network_interface.elastic.*.private_ip
    description = "The public IP address of the ptaf server"
}
