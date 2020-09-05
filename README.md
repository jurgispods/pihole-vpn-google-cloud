# Installation

## Prerequisites

###

- `terraform`
- `gcloud` (from Google Cloud SDK)

### Setup Google Cloud Account and Project

- Set up [Google Cloud Account](https://console.cloud.google.com/getting-started), if necessary
- Create a new project in Google Cloud Console and take note of the project ID.
    - The project must be [linked to a Billing Account](https://cloud.google.com/billing/docs/how-to/modify-project).

## Create Infrastructure

Authenticate Terraform to create resources on your behalf. Either:

1. Quick and easy: Run `gcloud auth application-default login`
2. Recommended for production: 
    - [Create a service account for Terraform](https://medium.com/@gmusumeci/how-to-create-a-service-account-for-terraform-in-gcp-google-cloud-platform-f75a0cf918d1)
(allows for fine-grained permission control)
    - Download the JSON credentials file
    - Reference the file under the key `credentials` in `provider.tf`

Insert your project ID as a value for the key `project` in `provider.tf`.

```
terraform init
terraform plan
terraform apply
```

## Configure Client Device(s)

### First client

The first client config is already created after the infrastructure is set up.

A QR code of the Wireguard config can be obtained by calling:

```
gcloud beta compute ssh --zone "us-east1-b" "root@pihole" --project <project-id> --command 'cat /root/wg0-client-2.conf | qrencode -t ansiutf8 -l L'
```

Alternatively, download the client config file directly:

```
gcloud beta compute scp --zone "us-east1-b" --project <project-id> root@pihole:/root/wg0-client-2.conf .
```

### Additional clients

For a new client config (e.g. for another device):

```
cat setup.sh | gcloud beta compute ssh --zone "us-east1-b" "root@pihole" --project <project-id> --command "bash -s /dev/stdin client"
```

This will out a QR code, as above. To download the new client config:

```
gcloud beta compute scp --zone "us-east1-b" --project <project-id> root@pihole:/root/wg0-client-3.conf .
```
