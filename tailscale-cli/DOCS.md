# FOR TESTING ONLY!

Tailscale (SSH, userspace networking) plus the Home Assistant `ha` CLI, running
with the `manager` role.

## First run

1. Start the add-on and open its **Log** tab.
2. `tailscale up` prints a login URL — open it once to authorize this node.
   Tailscale state is stored under `/data`, so this is a one-time step.
3. Make sure **Tailscale SSH is allowed** for this node in your tailnet ACLs.

## Usage

SSH into the node over Tailscale (default hostname `ha-cli`), then run `ha`
commands, e.g. `ha core info`, `ha addons`, `ha supervisor logs`.

The hostname is an optional config option (defaults to `ha-cli`).
