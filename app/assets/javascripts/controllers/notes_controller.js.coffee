angular.module("Litterary").controller "NotesController", ["$q", "NotesService", ($q, NotesService) ->
  getNote: (noteId) ->
    if @note
      $q.resolve @note
    else
      NotesService.show(noteId).then (note) =>
        @note = note
        note
]
