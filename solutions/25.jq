declare type local:game as {
  "!guess": "string",
  "!target": "string",
  "!country": "string",
  "!choices": [ "string" ],
  "!sample": "hexBinary",
  "!date": "date"
};
validate type local:game* {
  json-file("confusion-2014-03-02.json")
}
