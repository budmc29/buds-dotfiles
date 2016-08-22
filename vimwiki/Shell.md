# Shell Notes

- check if program is installed
```
  command -v foo >/dev/null 2>&1 || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; }

  type foo >/dev/null 2>&1 || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; }

  hash foo 2>/dev/null || { echo >&2 "I require foo but it's not installed.  Aborting."; exit 1; }
```
  [[oaeuoaeuoae]]
- change file extension recursivE
```
find test -type f -name '*.ext1' -print0 | xargs -0 rename 's/.ext1$/.ext2/'

```

- run bash function by calling them from cli
```
. ./file.bash && function parameter

```

- run bash code to the machine you ssh (run code on ssh)
```
ssh user@host <<'ENDSSH'
echo 'test'
ENDSSH

```

- copy text to sistem clipboard (xclip)
```
xclip -selection c filename.txt

```

- add ssh key to ssh-agent
```
ssh-add ~/.ssh/key

```

- generate ssh create ssh key
```
ssh-keygen

```

- remove set alias
```
unalias alis_name

```
