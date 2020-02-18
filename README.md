
# Installing Terraform Enterprise in demo mode and recovering it from snapshot 

In this project we will provide TF code that builds an environment in AWS Cloud and install Terraform Enterprise in a NAT instance with airgap installation.

## About Terraform Enterprise
Terraform Enterprise is on-prem version of Terraform Cloud. This means that it implements the functionality of Terraform Cloud in private managed and secured infrastructure with additional enterprise-grade architectural features like audit logging and SAML single sign-on.
Airgap installation means that no Internet access is required for the installation.


### Prerequisites
 - Install Terraform CLI:
Download and install accordingly to your OS as described here:
https://www.terraform.io/downloads.html
 - Have a account in AWS




### Open a terminal


 OS system | Operation
 ------------ | -------------
| Windows | Start menu -> Run and type cmd |
| Linux  |Start terminal |
| macOS | Press Command - spacebar to launch Spotlight and type "Terminal," then double-click the search result. |

### Download this repo
- clone the repo locally
```
clone https://github.com/yaroslav-007/ptfe-aws-airgap-install.git
cd ptfe-aws-airgap-install
```
# Prerequisite tasks

 - In main.tf AWS credentials should be populated
 - Ssh keys should be generated and put in ./ptfe-ec2/cert.pem and ./ptfe-ec2/privkey.pem
 - You have to have a domain and create zone in aws (https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/CreatingHostedZone.html) and populate its id in dns.tf
 - Obtain a license for TFE and located in ./ptfe-ec2/license-file.rli
 - Download Airgap bundle for the install and save in ./ptfe-ec2/Terraform.airgap
 - Download replicated and save it to ./ptfe-ec2/replicated.tar.gz from https://install.terraform.io/airgap/latest.tar.gz
 - Check ./ptfe-ec2/settings.json and ./ptfe-ec2/replicated.conf and change the needed setting that you will use.
 - Populate the public key in ptfe-server.tf



### Run terrafom 

Run terraform to build the infrastructure:
`terraform apply`

When terraform finished, open a browser for location `https://ptfe.example.com:8800/` (you should be able to access the ptfe instance for example with socks described here: https://www.digitalocean.com/community/tutorials/how-to-route-web-traffic-securely-without-a-vpn-using-a-socks-tunnel) and PTFE console should be available 

