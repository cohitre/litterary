angular.module("Litterary").service "NoteCitationsService", ["$http", ($http) ->
  index: (noteId) ->
    $http.get("/api/v1/notes/#{noteId}/citations").then (res) ->
      res.data

  create: (noteId, model) ->
    d =
      citation: model
    d.authenticity_token = $("meta[name=csrf-token]").attr("content")
    $http.post("/api/v1/notes/#{noteId}/citations", d).then (res) ->
      res.data
]
