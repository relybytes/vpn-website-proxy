#!/bin/bash

VARS='$PROXY_PASS_URL:$PROXY_LISTEN_PORT'

# Replace environment variables in nginx.conf.template and save to nginx.conf
envsubst "$VARS" < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# Function to establish VPN connection and capture output
establish_vpn_connection_and_capture_output() {
    # Start the VPN connection in the background and capture output to a file
    echo $VPN_PASS | openconnect --user=$VPN_USER --passwd-on-stdin $1 $VPN_URL > vpn_output.log 2>&1 &
    vpn_pid=$! # Save the PID of the OpenConnect process
}

# Function to check VPN connection status
check_vpn_connection() {
    # Wait for a bit to allow VPN connection to establish
    sleep 10

    # Check if OpenConnect process is running
    if ps -p $vpn_pid > /dev/null; then
        echo "VPN connection likely established."
        return 0
    else
        echo "VPN connection failed."
        return 1
    fi
}

# Initial VPN connection attempt without --servercert
establish_vpn_connection_and_capture_output ""
check_vpn_connection

# Check for certificate verification failure
if grep -q 'Server certificate verify failed' vpn_output.log; then
    echo "Initial VPN connection failed due to certificate verification. Attempting to extract server cert key."

    # Extract the server cert key
    SERVER_CERT_PIN=$(grep -- '--servercert ' vpn_output.log | awk '{print $NF}')

    # If a server cert key was found
    if [ -n "$SERVER_CERT_PIN" ]; then
        echo "Found server cert key: $SERVER_CERT_PIN. Retrying with --servercert option."

        # Retry VPN connection with --servercert
        establish_vpn_connection_and_capture_output "--servercert=$SERVER_CERT_PIN"
        check_vpn_connection
    else
        echo "No server cert key found in the output."
    fi
fi

echo "Start nginx..."
# Start Nginx in the foreground
nginx -g 'daemon off;'
