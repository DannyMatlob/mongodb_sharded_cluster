source ips.sh

# Check if a number between 1 and 5 was provided
if [[ $1 -lt 1 || $1 -gt 5 ]]; then
    echo "Usage: $0 <number 1-5>"
    exit 1
fi

# Get the corresponding IP address
IP_ADDRESS=${IPS[$(( $1 - 1 ))]}

# SSH into the selected IP address
ssh -i "$KEY" "$USER@$IP_ADDRESS"