let $path := "git-archive.json"
let $events := json-file($path)
let $actors := $events.actor
let $logins := $actors.login
let $distinct-logins := distinct-values($logins)
return count($distinct-logins)
