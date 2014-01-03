angular.module("Litterary").service "NotesService", ["$http", ($http) ->
  getAuthenticityToken = ->
    $("meta[name=csrf-token]").attr("content")

  draft: ->
    $http.get("/api/v1/notes/draft").then (res) ->
      res.data

  show: (noteId) ->
    $http.get("/api/v1/notes/#{noteId}").then (res) ->
      res.data

  update: (model) ->
    data = model
    data.authenticity_token = getAuthenticityToken()
    $http.post("/api/v1/notes", data).then (res) ->
      res.data

  citation: (noteId, model) ->
    d =
      citation: model
    d.authenticity_token = getAuthenticityToken()
    $http.post("/api/v1/notes/#{noteId}/citations", d).then (res) ->
      res.data
]
