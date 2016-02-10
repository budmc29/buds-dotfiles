# Vim Notepad

- vimwiki search for text
```
:VWS /text/
:lopen # show all results
:lnext # show next result

```

- replace text in file
```
:%s /foo/bar/gc
# g = global means everywhere in file
# c = confirm before replace
# e = ignore erros (good for macros)

```

- replace text in multiple files
```
vim *.rb # add all .rb files from the folder in :arg
vim **/*.rb # load all .rb files from the folder in vim

:args # show all files in arglist

:argdo %s/foo/bar/ge | update! # update! ignores file opened in another buffer

# argdo applies the modification to all files in the arg list

```




