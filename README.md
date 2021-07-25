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
PATH=/home/ubuntu/.local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin

* * * * * /home/ubuntu/armada-ping/ping.sh | tee -a /home/ubuntu/mainnet-relay/armada-ping.log
```

6. Check the logs

```bash
cat /home/ubuntu/mainnet-relay/armada-ping.log
```

output:
```
Sun Jul 25 16:58:01 UTC 2021 { "node_version": "1.27.0", "slot_height": "35665977", "remaining_kes_periods": "44" }
```