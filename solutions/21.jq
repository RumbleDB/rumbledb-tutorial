declare type local:histogram as { "commits" : "short", "count" : "long" };
validate type local:histogram* {
  for $event in json-file("git-archive.json")
  group by $nb-commits := (size($event.payload.commits), 0)[1]
  order by $nb-commits
  return { "commits" : $nb-commits, "count" : count($event) }
}
