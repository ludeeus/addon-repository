#!/usr/bin/with-contenv bashio

bashio::log.info "Starting tailscaled (userspace, state in /data/tailscale)..."
tailscaled --state=/data/tailscale/tailscaled.state --tun=userspace-networking &

bashio::log.info "Bringing Tailscale up with SSH (first run prints a login URL)..."
tailscale up --ssh --hostname="$(bashio::config 'hostname' 'ha-cli')"

bashio::log.info "Ready. SSH in over Tailscale, then use the 'ha' CLI."
wait
