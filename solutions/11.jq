count(
  json-file(
 "git-archive.json"
  )[size($$.payload.commits) ge 5]
)
