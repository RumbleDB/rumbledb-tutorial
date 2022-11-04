let $path as string := "git-archive.json"
let $events as object* := json-file($path)
let $actors as object* := $events.actor
let $logins as string* := $actors.login
let $distinct-logins as string* := distinct-values($logins)
let $count as integer := count($distinct-logins)
return $count
