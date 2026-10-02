# tv-control

Control je TV via HDMI-CEC (Consumer Electronics Control).

## Wat is HDMI-CEC?

HDMI-CEC is een protocol dat apparaten via de HDMI-kabel laten communiceren. Je kunt bijvoorbeeld je TV aan/uit zeten, volume aanpassen, of input switchen vanaf een Raspberry Pi of andere CEC-ondersteunde apparaten.

## Vereisten

- HDMI-CEC ondersteuning op je TV (meeste moderne TV's hebben dit)
- `cec-client` geïnstalleerd: `sudo apt-get install cec-utils`
- Raspberry Pi of andere Linux machine met HDMI-uitgang

## Gebruik

```bash
# TV aanzeten
echo "on 0" | cec-client -s -d 1

# TV uitzeten
echo "standby 0" | cec-client -s -d 1

# Volume omhoog
echo "volup" | cec-client -s -d 1

# Volume omlaag
echo "voldown" | cec-client -s -d 1

# Mute toggle
echo "mute" | cec-client -s -d 1

# Input switchen naar HDMI 1
echo "tx 4f:82:10:00" | cec-client -s -d 1
```

## Automatisering

Gebruik `cron` of een `systemd` service om automatisch je TV aan/uit te zeten:

```bash
# TV om 07:00 aanzeten
0 7 * * * echo "on 0" | cec-client -s -d 1

# TV om 23:00 uitzeten
0 23 * * * echo "standby 0" | cec-client -s -d 1
```

## Problemen oplossen

- **Geen CEC-berichten ontvangen**: Controleer of CEC is ingeschakeld op je TV (soms genoemd Anynet+, BRAVIA Link, SimpLink, etc.)
- **Permission denied**: Voeg je gebruiker toe aan de `video` groep: `sudo usermod -a -G video $USER`
- **cec-client niet gevonden**: Installeer met `sudo apt-get install cec-utils`

---

## 🎥 Gource Visualization

De ontwikkelhistorie van dit project in een film:

<video src="https://raw.githubusercontent.com/itsdarklikehell/tv-control/master/gource.mp4" controls width="100%"></video>