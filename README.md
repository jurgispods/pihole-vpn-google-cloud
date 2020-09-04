# Installation

## Prerequisites

###

- `terraform`
- `gcloud` (from Google Cloud SDK)

### Setup Google Cloud Account and Project

TODO

## Create Infrastructure

```
terraform init
terraform plan
terraform apply
```

## Configure Client Device(s)

The first client config is already created after the infrastructure is set up.

A QR code of the Wireguard config can be obtained by calling:

```
gcloud beta compute ssh --zone "us-east1-b" "root@pihole" --project <myproject> --command 'cat /root/wg0-client-2.conf | qrencode -t ansiutf8 -l L'
```

For a new client config (e.g. for another device):

```
cat setup.sh | gcloud beta compute ssh --zone "us-east1-b" "root@pihole" --project <myproject> --command "bash -s /dev/stdin client"
```