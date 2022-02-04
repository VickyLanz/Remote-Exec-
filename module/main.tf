provider "google" {
  project = var.project_id
  zone  =var.zone
  region = var.region
}
resource "google_compute_instance" "first_instance" {
  machine_type = "e2-medium"
  name         = "first-instance"
  tags = ["http-server","https-server"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"
    access_config {

    }
  }
}
 resource "null_resource" "null" {
   depends_on = [google_compute_instance.first_instance]
   connection {
    type = "ssh"
    user =var.user
    host  ="${google_compute_instance.first_instance.network_interface.0.access_config[0].nat_ip}"
    private_key ="${file(var.privatekeypath)}"
  }
   provisioner "file" {
    source ="${var.path}"
    destination ="/home/${var.user}/script.sh"
  }
  provisioner "remote-exec" {

    inline = [
    "cd /home/${var.user}/",
      "sudo chmod +x script.sh",
      "./script.sh"
    ]
  }
 }