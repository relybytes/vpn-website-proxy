# Use an official Ubuntu as a parent image
FROM ubuntu:24.04

# Install openconnect, curl, socat, and nginx
RUN apt-get update && \
    apt-get install -y openconnect curl socat nginx gettext-base && \
    rm -rf /var/lib/apt/lists/*

# Copy the VPN configuration script
COPY vpn-connect.sh /usr/local/bin/vpn-connect.sh
RUN chmod +x /usr/local/bin/vpn-connect.sh

# Copy the Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf.template

# Use a shell script that starts both Openconnect and Nginx
CMD ["/usr/local/bin/vpn-connect.sh"]
