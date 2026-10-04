# tv-control

Control your TV over HDMI using CEC (Consumer Electronics Control).

## Requirements

- Raspberry Pi with HDMI-CEC support
- `cec-client` package installed

## Installation

```bash
sudo apt-get install cec-utils
git clone https://github.com/itsdarklikehell/tv-control.git
cd tv-control
```

## Usage

```bash
# Turn TV on
echo "on 0" | cec-client -s -d 1

# Turn TV off
echo "standby 0" | cec-client -s -d 1

# Get TV status
echo "pow 0" | cec-client -s -d 1
```

## Contributing

Zie [CONTRIBUTING.md](CONTRIBUTING.md) voor richtlijnen.

## License

Zie [LICENSE](LICENSE) voor details.

---

## 🎥 Gource Visualization

De ontwikkelhistorie van dit project in een film:

<video src="https://raw.githubusercontent.com/itsdarklikehell/tv-control/master/gource.mp4" controls width="100%"></video>
