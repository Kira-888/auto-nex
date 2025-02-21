# auto-nex-restart

# Clone the Repository
```console
cd
git clone https://github.com/Kira-888/auto-nex.git
cd auto-nex
```
# containers.txt

add the number of containers in this list
```console
nano containers.txt
```
# Set Permissions

```console
chmod +x /root/auto-nex/monitor_nexus.sh
```

# Automate with Cron Job

```console
crontab -e
```
select nano thats the easy editor

Add this line at the bottom:
```console
* * * * * /root/auto-nex/monitor_nexus.sh >> /root/auto-nex/nexus_log.txt 2>&1
```
Restart the Cron Service

```console
systemctl restart cron
```
check its status: its should be active(ignore any errors below)

```console
systemctl status cron
```

what happens:

this cron job checks the containers every minute if the container is live or not
if not it restarts and the logs will be saved in that directory
