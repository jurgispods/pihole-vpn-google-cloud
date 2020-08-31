provider "google" {
  credentials = file("pihole-vpn-287719-d2929f379a7c.json")
  project     = "pihole-vpn-287719"
  region      = "us-east1"
  version     = "~> 3.36"
}
