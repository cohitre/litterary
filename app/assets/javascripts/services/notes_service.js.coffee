angular.module("Litterary").service "NotesService", ["$http", ($http) ->
  show: (noteId) ->
    $http.get("/api/v1/notes/#{noteId}").then (res) ->
      res.data
]
