# Setup

1. Install dependencies:
  ```bash
  sudo yum update -y
  sudo yum install git -y
  git clone https://github.com/timesler/docker-openvpn-server.git
  cd docker-openvpn-server
  bash setup-aws.sh
  ```
1. Logout and back in.
1. Start OpenVPN server:
  ```bash
  bash start-aws.sh <public IP>
  ```
1. Create user profiles:
  ```bash
  docker exec openvpn-server bash create_user_profile.sh tim
  ```
