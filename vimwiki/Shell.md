# Shell Notes

- check if program is installed
```
  command -v foo >/dev/null 2>&1 || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; }

  type foo >/dev/null 2>&1 || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; }

  hash foo 2>/dev/null || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; }

```

- change file extension recursive
```
find test -type f -name '*.ext1' -print0 | xargs -0 rename 's/.ext1$/.ext2/'

```

- run bash function by calling them from cli
```
. ./file.bash && function parameter

```

- get current time in bash
```
time=`date +%Y-%m-%d\ %H:%M:%S` # 2016-01-17 22:31:20

```

- hello world in cron
```
# first test cron
* * * * * root date >> /home/bud/date.txt
# minute, hour, day of the month, month, day of the week (sunday = 0)
# user
# command to be ran

```
