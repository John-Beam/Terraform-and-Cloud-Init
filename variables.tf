#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------

variable "availability_zone" {
  type    = string
  default = "ru-msk-comp1p"
}


variable "C2_PROJECT" {
  type = string 
  default = "DPIC.EDU"
}


variable "ptaf_node_id" {
  type    = string
  default = "cmi-00F8AEF7" /**/
}

variable "ptaf_node_instance_type" {
  type    = string
  /*default = "m5.2large"*/
  default = "m5.4large"
}

variable "instance_count" {
  default = "1"
}