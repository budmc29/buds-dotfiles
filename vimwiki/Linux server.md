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

- install elasticsearch as a service
```
add-apt-repository ppa:webupd8team/java

apt-get update

apt-get -y install oracle-java8-installer

wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

# add elasticsearch repository
echo "deb http://packages.elastic.co/elasticsearch/1.7/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-1.7.list

apt-get update && sudo apt-get -y install elasticsearch

# start elasticsearch process
sudo service elasticsearch start

# start elasticsearch with boot
update-rc.d elasticsearch defaults 95 10

```
