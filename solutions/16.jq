let $events := json-file("git-archive.json")
for $event in $events
let $nb-commits := size($event.payload.commits)
let $nb-commits := if(exists($nb-commits)) then $nb-commits else 0
return {
  "id" : $event.id,
  "number of commits" : $nb-commits
}

