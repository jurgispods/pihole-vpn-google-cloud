data "google_compute_network" "default" {
  name                    = "default"
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
    network = data.google_compute_network.default.self_link
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  metadata_startup_script = file("setup.sh")
}

resource "google_compute_firewall" "firewall" {
  name    = "allow-wireguard"
  network = data.google_compute_network.default.name
  direction = "INGRESS"
  priority = 1000
  enable_logging = false
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["pihole-vpn"]

  allow {
    protocol = "udp"
    ports    = ["51515"]

  }

  source_tags = ["web"]
}

