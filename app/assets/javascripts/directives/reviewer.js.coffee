angular.module("Litterary").directive "reviewer", ["NotesService", "$compile", "$sce", (NotesService, $compile, $sce) ->
  (scope, element, attributes) ->
    selectableBlock = new SelectableTextBlock(element.find("pre"))
    selectableBlock.select (range) ->
      scope.$apply ->
        scope.highlight(range.start, range.end)

    noteId = parseInt(attributes.noteId)

    scope.note = null
    scope.noteString = null
    scope.isCommentable = ->
      scope.citation == undefined
    scope.clearCitation = ->
      scope.citation = undefined

    NotesService.show(noteId).then (note) ->
      scope.note = note
      scope.noteString = aString(note.body)
      for citation in note.citations
        scope.highlight(citation.range.start, citation.range.end)

    scope.getDocumentHtml = ->
      if scope.noteString?
        $sce.trustAsHtml scope.noteString.toHtml()
      else
        $sce.trustAsHtml "Loading..."

    scope.highlight = (start, end) ->
      text = scope.note.body.slice(start, end)
      scope.noteString.range(start, end).addClass("highlight")

    scope.getQueryRangeCommentArea = (st, end) ->
      scope.citation =
        comment: ""
        range:
          start: st
          end: end
      element.find("[range-comment-form]")
]
