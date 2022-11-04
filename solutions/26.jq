for $game in json-file("confusion-2014-03-02.json")
group by $g := $game.guess
order by count($game) descending
return { "g" : $g, "c" : count($game) }
