sudo yum update -y
sudo yum install git -y
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user
https://github.com/timesler/docker-openvpn-server.git
cd docker-openvpn-server
docker build --build-arg "HOST=127.0.0.1" . -t openvpn-server:latest
