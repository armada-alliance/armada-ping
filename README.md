<p align="center"><img width="200px" src="https://armada-alliance.com/ship-420.png"></img></p>

# Armada Ping

Armada Ping sends your remaining kes periods, slot height and node version to the Armada Alliance website.

This way we can notify you when:
- Your node is down
- Your slot height is out of sync
- Your kes is about to expire
- Your node version is out of date

## Installation

1. Clone repo
```bash
git clone https://github.com/armada-alliance/armada-ping.git
```

2. Request token from one of the admins

3. Configure the script
```
ARMADA_TOKEN=<YOUR_TOKEN>
ARMADA_ENDPOINT=https://api.sublayer.io/armada-api/ping
```

4. Edit crontab
```bash
crontab -e
```

5. Add cronjob that executes the ping script
```bash
*/5 * * * * /home/ubuntu/armada-ping/ping.sh | tee -a /home/ubuntu/mainnet-relay/armada-ping.log
```