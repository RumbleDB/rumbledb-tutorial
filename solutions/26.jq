for $game in parquet-file("confusion-2014-03-02.parquet")
group by $g := $game.guess
order by count($game) descending
return { "g" : $g, "c" : count($game) }
