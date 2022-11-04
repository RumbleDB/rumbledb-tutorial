import module namespace m = "http://www.rumbledb.org/samples/module.jq";

m:count(json-file("confusion-2014-03-02.json"))
