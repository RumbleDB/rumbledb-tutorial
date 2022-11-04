for $event in json-file("git-archive.json")
let $nb-commits := size($event.payload.commits)
order by $nb-commits descending
return project($event, ("id", "type"))
