# create service.
curl -XPOST localhost:9000/graphs/createService -H 'Content-Type: Application/json' -d '
{"serviceName": "s2graph"}
'

# create label.
curl -XPOST localhost:9000/graphs/createLabel -H 'Content-Type: Application/json' -d '
{
    "label": "graph_test",
    "srcServiceName": "s2graph",
    "srcColumnName": "account_id",
    "srcColumnType": "long",
    "tgtServiceName": "s2graph",
    "tgtColumnName": "account_id",
    "tgtColumnType": "long",
    "indexProps": {
        "time": 0,
        "weight": 0
    },
    "props": {
        "is_hidden": false,
        "is_blocked": false
    }
}
'
# add edges
curl -XPOST localhost:9000/graphs/edges/insert -H 'Content-Type: Application/json' -d '
[
  {"from":1,"to":101,"label":"graph_test","props":{"time":-1, "weight":10},"timestamp":193829192},
  {"from":1,"to":102,"label":"graph_test","props":{"time":0, "weight":10},"timestamp":193829192},
  {"from":1,"to":103,"label":"graph_test","props":{"time":1, "weight":10},"timestamp":193829192},
  {"from":1,"to":104,"label":"graph_test","props":{"time":-2, "weight":10},"timestamp":193829192}
]
'

# select edges
curl -XPOST localhost:9000/graphs/getEdges -H 'Content-Type: Application/json' -d '
{
    "srcVertices": [{"serviceName": "s2graph", "columnName": "account_id", "id":1}],
    "steps": [
      [{"label": "graph_test", "direction": "out", "offset": 0, "limit": 100}]
    ]
}
'