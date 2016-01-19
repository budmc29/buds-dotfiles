# Linux Notepad

- fix timout problems (ntptime, ntpdate)
  login as root user
```
ntpdate ntp.ubuntu.com

```

- see all cronjobs on machine
```
for USERS in $(cat /etc/passwd | cut -d: -f1); do crontab -l -u $USERS; done

```
