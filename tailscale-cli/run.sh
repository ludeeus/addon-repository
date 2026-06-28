#!/usr/bin/with-contenv bashio

# Explicit option wins; otherwise use ha-cli-<random7>, generated once and
# persisted in /data so it stays stable across restarts.
if bashio::config.has_value 'hostname'; then
  hostname="$(bashio::config 'hostname')"
elif [ -s /data/hostname ]; then
  hostname="$(cat /data/hostname)"
else
  hostname="ha-cli-$(tr -dc 'a-z0-9' </dev/urandom | head -c7)"
  echo "${hostname}" > /data/hostname
fi

bashio::log.info "Starting tailscaled (userspace, state in /data/tailscale)..."
tailscaled --state=/data/tailscale/tailscaled.state --tun=userspace-networking &

bashio::log.info "Bringing Tailscale up with SSH as ${hostname} (first run prints a login URL)..."
tailscale up --ssh --hostname="${hostname}"

bashio::log.info "Ready. SSH in over Tailscale, then use the 'ha' CLI."
wait
