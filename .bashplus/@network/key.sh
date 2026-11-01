#!/bin/bashlib/operation
operation @network
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "Error bashpl"
    exit 1
fi

NETLIB_TIMEOUT=${NETLIB_TIMEOUT:-5}
NETLIB_USER_AGENT="BashNetLib/1.0"


net_ping() {
    local host="$1"
    if [[ -z "$host" ]]; then
        return 2
    fi

    ping -c 1 -W "$NETLIB_TIMEOUT" "$host" >/dev/null 2>&1
    return $?
}


net_port_check() {
    local host="$1"
    local port="$2"
    
    if [[ -z "$host" || -z "$port" ]]; then
        return 2
    fi

    timeout "$NETLIB_TIMEOUT" bash -c "cat < /dev/null > /dev/tcp/${host}/${port}" 2>/dev/null
    return $?
}

net_get() {
    local url="$1"
    if [[ -z "$url" ]]; then
        return 2
    fi

    curl -sSfL \
         --max-time "$NETLIB_TIMEOUT" \
         -A "$NETLIB_USER_AGENT" \
         "$url"
    return $?
}


net_post_json() {
    local url="$1"
    local json_data="$2"

    if [[ -z "$url" ]]; then
        return 2
    fi

    curl -sSfL \
         -X POST \
         -H "Content-Type: application/json" \
         -A "$NETLIB_USER_AGENT" \
         --max-time "$NETLIB_TIMEOUT" \
         -d "$json_data" \
         "$url"
    return $?
}


net_my_public_ip() {
    local services=(
        "https://ifconfig.me"
        "https://ipify.org"
        "https://icanhazip.com"
    )

    for service in "${services[@]}"; do
        if res=$(curl -sSf --max-time 3 "$service" 2>/dev/null); then
            return 0
        fi
    done
    
    return 1
}