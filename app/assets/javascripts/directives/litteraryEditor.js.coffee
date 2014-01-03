angular.module("Litterary").directive "litteraryEditor", ["NotesService", (NotesService) ->
  ScopeExtensions =
    load: ->
      NotesService.draft().then (note) =>
        @note = note

    save: ->
      @isSaving = true
      NotesService.update(@note).then (note) =>
        @lastSaved = new Date()
        @isSaving = false

    getLastSavedAtText: ->
      if @lastSaved?
        hours = @lastSaved.getHours()
        minutes = @lastSaved.getMinutes()
        seconds = @lastSaved.getSeconds()
        if minutes < 10
          minutes = "0" + minutes
        if seconds < 10
          seconds = "0" + seconds
        [hours, minutes, seconds].join(":")
      else
        ""

    getSaveButtonText: ->
      if @isSaving
        return "Saving..."
      else
        return "Save"

  (scope, element, attributes) ->
    angular.extend scope, ScopeExtensions
    scope.load(attributes.noteId)
]
