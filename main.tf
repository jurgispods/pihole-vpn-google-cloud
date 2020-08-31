resource "google_compute_network" "pihole_vpn_network" {
  name                    = "pihole-vpn-network"
  auto_create_subnetworks = "true"
}

resource "google_compute_address" "static" {
  name = "ipv4-address"
}

data "google_compute_image" "ubuntu_image" {
  family  = "ubuntu-2004-lts"
  project = "ubuntu-os-cloud"
}

resource "google_compute_instance" "pihole" {
  name         = "pihole"
  machine_type = "f1-micro"
  zone         = "us-east1-b"

  tags = ["gcp-demo", "pihole-vpn"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu_image.self_link
    }
  }

  network_interface {
    network = google_compute_network.pihole_vpn_network.self_link
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  metadata_startup_script = "echo hi > /test.txt"
}
