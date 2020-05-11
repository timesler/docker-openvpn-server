# Setup

1. Deploy OpenVPN server:
  ```bash
  sudo yum update -y
  sudo yum install git -y
  git clone https://github.com/timesler/docker-openvpn-server.git
  bash setup-aws.sh <public IP>
  ```
1. Create user profiles:
  ```bash
  docker exec openvpn-server bash create_user_profile.sh tim
  ```
