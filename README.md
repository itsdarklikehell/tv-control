# tv-control

Control your TV over HDMI-CEC from the command line or an interactive menu.

## Features

- **Power control** — Turn TV on/off via CEC
- **Status check** — Query TV power state
- **Source switching** — Switch to Raspberry Pi input
- **Interactive menu** — Whiptail-based TUI
- **Dry-run mode** — Test without sending CEC commands
- **Logging** — Optional log file with timestamps
- **Custom CEC client** — Override the cec-client command

## Requirements

- `cec-client` (install: `sudo apt-get install cec-utils`)
- `whiptail` (install: `sudo apt-get install whiptail`)

## Installation

### Quick install

```bash
sudo ./install.sh
```

This copies all scripts to `/usr/local/bin/` and makes them executable.

### Custom install directory

```bash
sudo ./install.sh /opt/tv-control
```

### Manual install

```bash
cp tv-control.sh tvon.sh tvoff.sh tvstat.sh tvsource.sh /usr/local/bin/
chmod +x /usr/local/bin/tv-*.sh
```

## Usage

### Command line

```bash
tv-control [on|off|status|source|menu]
```

| Command | Description |
|---------|-------------|
| `on` | Turn TV on |
| `off` | Turn TV off |
| `status` | Check TV power status |
| `source` | Switch to Raspberry Pi source |
| `menu` | Interactive whiptail menu (default) |

### Wrapper scripts

```bash
tvon       # Turn TV on
tvoff      # Turn TV off
tvstat     # Check TV status
tvsource   # Switch TV source
```

### Environment variables

| Variable | Default | Description |
|----------|---------|-------------|
| `DRY_RUN` | `false` | Simulate commands without executing |
| `LOG_FILE` | `/tmp/tv-control.log` | Custom log file path |
| `CEC_CLIENT` | `cec-client RPI -s -d 1` | Custom cec-client command |

### Examples

```bash
# Turn on with custom log file
LOG_FILE=/var/log/tv.log tv-control on

# Dry run (no actual CEC commands)
DRY_RUN=true tv-control on

# Use custom CEC client
CEC_CLIENT="cec-client -s -d 8" tv-control status

# Interactive menu
tv-control menu
```

## Testing

Run the test suite:

```bash
./test_tv-control.sh
```

Tests cover:
- Script existence and permissions
- Bash syntax validation
- Shellcheck (if installed)
- DRY_RUN mode for all commands
- Wrapper script functionality
- Invalid argument handling
- Usage message display

## CI/CD

- **CI** — Runs on push/PR to master/main via reusable workflow
- **Gource** — Generates development timeline video on push to master

## Project structure

```
tv-control/
├── tv-control.sh      # Main script with all commands
├── tvon.sh            # Wrapper: turn on
├── tvoff.sh           # Wrapper: turn off
├── tvstat.sh          # Wrapper: status
├── tvsource.sh        # Wrapper: switch source
├── install.sh         # Installation script
├── test_tv-control.sh # Test suite
├── .github/
│   └── workflows/
│       ├── ci.yml     # CI workflow
│       └── gource.yml # Gource visualization
├── .gitignore
├── Dockerfile
└── README.md
```

## Docker

Build and run in a container:

```bash
docker build -t tv-control .
docker run --rm --device /dev/tty0 tv-control on
```

## License

MIT — see [LICENSE](LICENSE)
