FROM alpine:latest

LABEL maintainer="Tim Esler <tim.esler@gmail.com>"

# Testing: pamtester
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && \
    apk add --update openvpn iptables bash easy-rsa openvpn-auth-pam google-authenticator pamtester && \
    ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

# Needed by scripts
ENV OPENVPN /etc/openvpn
ENV EASYRSA /usr/share/easy-rsa
ENV EASYRSA_PKI $OPENVPN/pki
ENV EASYRSA_VARS_FILE $OPENVPN/vars

# Prevents refused client connection because of an expired CRL
ENV EASYRSA_CRL_DAYS 3650

# Internally uses port 1194/udp, remap using `docker run -p 443:1194/tcp`
EXPOSE 1194/udp

ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

# Add support for OTP authentication using a PAM module
ADD ./otp/openvpn /etc/pam.d/

ARG HOST=127.0.0.1

RUN ovpn_genconfig -u udp://${HOST}:1194

ENV EASYRSA_BATCH=1
RUN ovpn_initpki nopass

RUN echo "easyrsa build-client-full \$1 nopass" > create_user_profile.sh; \
    echo "ovpn_getclient \$1 > /client-profiles/\$1.ovpn" >> create_user_profile.sh; \
    chmod +x create_user_profile.sh

CMD ["ovpn_run"]
