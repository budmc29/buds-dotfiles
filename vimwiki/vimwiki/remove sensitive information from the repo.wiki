{{{ 
  git filter-branch --force --index-filter \
  'git rm --cached --ignore-unmatch NAME_OF_FILE' \
  --prune-empty --tag-name-filter cat -- --all
  then 
  
  git push origin --force --all
  
}}}
  if success then it will display something like this
{{{   
    Rewrite 48dc599c80e20527ed902928085e7861e6b3cbe6 (266/266)
    Ref 'refs/heads/master' was rewritten
}}}
