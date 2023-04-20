resource "google_compute_instance" "nginx" {
  count = "${length(var.vm_name)}"
  name         = "${element(var.vm_name,count.index)}"
  machine_type = "n1-standard-1"
  zone         = "${var.region}-a"

  tags = ["nginx", "webapp"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7-v20200205"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    name = "nginx"
    ssh-keys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
  }

  metadata_startup_script = "${file("startup.sh")}"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}