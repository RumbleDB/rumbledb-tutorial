count(
  distinct-values(
    json-file(
      "git-archive.json"
    ).payload.commits[[1]].author.email
  )
)
