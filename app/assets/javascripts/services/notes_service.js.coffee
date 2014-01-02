angular.module("Litterary").service "NotesService", ["$http", ($http) ->
  show: (noteId) ->
    $http.get("/api/v1/notes/#{noteId}").then (res) ->
      res.data

  citation: (noteId, model) ->
    d =
      citation: model
    d.authenticity_token = $("meta[name=csrf-token]").attr("content")
    $http.post("/api/v1/notes/#{noteId}/citations", d).then (res) ->
      res.data
]
