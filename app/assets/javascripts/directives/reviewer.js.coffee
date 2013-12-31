angular.module("Litterary").directive "reviewer", ["NotesService", "$compile", "$sce", (NotesService, $compile, $sce) ->
  ScopeExtensions =
    hasNote: ->
      @body?

    getNote: (noteId) ->
      NotesService.show(noteId).then (note) =>
        @body = aString(note.body)
        @citations = note.citations
        @

    highlight: (start, end) ->
      @range(start, end).addClass "highlight"

    getActiveHighlight: ->
      if @body
        ranges = @body.filter (i, range) ->
          range.hasClass "highlight-live"
        if ranges.ranges.length > 0
          return ranges
        else
          return null
      else
        return null

    hasActiveHighlight: ->
      @citation?

    clearSelection: ->
      document.getSelection().removeAllRanges()

    blurActiveHighlight: ->
      @citation = null
      ranges = @body.filter (i, range) ->
        range.hasClass "highlight-live"
      ranges.removeClass "highlight-live"
      @

    focusActiveHighlight: (start, end) ->
      @blurActiveHighlight()
      @range(start, end).addClass("highlight-live")
      @citation =
        comment: ""
        range:
          start: start
          end: end

    range: (start, end) ->
      @body.range(start, end)

    toHtml: ->
      @body.toHtml()

    getDocumentHtml: ->
      if @hasNote()
        $sce.trustAsHtml @toHtml()
      else
        $sce.trustAsHtml "Loading..."

  link: (scope, element, attributes) ->
    angular.extend scope, ScopeExtensions
    noteId = parseInt(attributes.noteId)
    scope.getNote(noteId).then (note) ->
      for citation in note.citations
        scope.highlight(citation.range.start, citation.range.end)

    selectableBlock = new SelectableTextBlock(element.find("pre"))
    selectableBlock.select (range) ->
      scope.$apply ->
        scope.focusActiveHighlight(range.start, range.end)
      scope.clearSelection()

    scope.getLiveHighlight = ->
      element.find("pre .highlight-live")

    scope.positionCommentForm = (childScope, element) ->
      span = @getLiveHighlight()
      position = span.position()

      element.css(
        top: position.top - 173
        left: position.left
      )
      childScope.citation = scope.citation
]
