terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "1.35.0"
    }
  }
}

resource "openstack_compute_instance_v2" "vm1" {

  count             = "0"
  name              = "demo2"
  image_name        = "Ubuntu 20.04 LTS"
  availability_zone = "nova"
  flavor_name       = "iops20.xs"
  key_pair          = "mykey"
  config_drive      = true
  user_data         = "#cloud-config\npassword: deleteme"
  security_groups   = ["default"]

  network {
    name = "external_network"
  }

  connection {
    user        = "root"
    host        = openstack_compute_instance_v2.vm1[0].access_ip_v4
    private_key = file("/root/.ssh/mykey.pri")
  }

  provisioner "remote-exec" {
    inline = [
      "apt-get -y install apache2 mysql-server php7.4 php7.4-mysql libapache2-mod-php7.4 php7.4-cli php7.4-cgi php7.4-gd",
    ]
  }

  provisioner "file" {
    source      = "install.sh"
    destination = "/tmp/install.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install.sh",
      "/tmp/install.sh wpdb wpdbpass MyTitle adminuser adminpass admin@site.tld",
    ]
  }

}
