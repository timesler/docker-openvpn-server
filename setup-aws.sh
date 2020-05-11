sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user
cd docker-openvpn-server
docker build --build-arg "HOST=$1" . -t openvpn-server:latest
docker run --name openvpn-server --restart=always -d -p 1194:1194/udp \
    -v $PWD/client-profiles:/client-profiles --cap-add=NET_ADMIN openvpn-server
