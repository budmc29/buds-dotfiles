# Mercurial Notebook

- see commits in reverse order
```
hg log -r:

```

- how to modify the last commit
```
hg commit --amend -m "update last commit"

```

- see diff of a revision
```
hg log -v -p -r 1234

```

- limit the number of revisions you get from hglog
```
hg log --limit 10

```
