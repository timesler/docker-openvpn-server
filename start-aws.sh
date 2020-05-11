cd docker-openvpn-server
bash docker build --build-arg "HOST=$1" . -t openvpn-server:latest
docker run --name openvpn-server --restart=always -d -p 1194:1194/udp \
    -v $PWD/client-profiles:/client-profiles --cap-add=NET_ADMIN openvpn-server
