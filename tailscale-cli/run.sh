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

mkdir -p /data/tailscale

bashio::log.info "Starting tailscaled (userspace, state in /data/tailscale)..."
tailscaled --state=/data/tailscale/tailscaled.state --tun=userspace-networking &

bashio::log.info "Waiting for the tailscaled socket..."
for _ in $(seq 1 30); do
  [ -S /var/run/tailscale/tailscaled.sock ] && break
  sleep 0.5
done
[ -S /var/run/tailscale/tailscaled.sock ] || bashio::exit.nok "tailscaled failed to start"

bashio::log.info "Bringing Tailscale up with SSH as ${hostname} (first run prints a login URL)..."
tailscale up --ssh --hostname="${hostname}"

bashio::log.info "Ready. SSH in over Tailscale, then use the 'ha' CLI."
wait
