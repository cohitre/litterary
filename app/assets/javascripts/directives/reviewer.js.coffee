angular.module("Litterary").directive "reviewer", ["NotesService", "$compile", "$sce", (NotesService, $compile, $sce) ->
  controller: "NotesController"
  link: (scope, element, attributes, controller) ->
    noteId = parseInt(attributes.noteId)
    controller.getNote(noteId).then (note) ->
      scope.note = note
      scope.noteString = aString(note.body)
      for citation in note.citations
        scope.highlight(citation.range.start, citation.range.end)

    selectableBlock = new SelectableTextBlock(element.find("pre"))
    selectableBlock.select (range) ->
      scope.$apply ->
        scope.highlight(range.start, range.end)

    scope.note = null
    scope.noteString = null
    scope.isCommentable = ->
      scope.citation == undefined
    scope.clearCitation = ->
      scope.citation = undefined

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
