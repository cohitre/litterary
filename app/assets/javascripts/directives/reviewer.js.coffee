angular.module("Litterary").directive "activeComments", [->
  template: """
  <div>
    <div ng-repeat="citation in activeCitations">
      {{citation.comment}}
    </div>
  </div>
  """
]
angular.module("Litterary").directive "reviewer", ["NotesService", "$compile", "$sce", (NotesService, $compile, $sce) ->
  ScopeExtensions =
    hasNote: ->
      @body?

    showCitation: (citation) ->
      range = citation.range
      @range(range.start, range.end).addClass "highlight-hover"

    hideCitation: (citation) ->
      range = citation.range
      @range(range.start, range.end).removeClass "highlight-hover"

    getCitation: (id) ->
      cs = for citation in @citations when citation.id == id
        citation
      cs[0]

    getNote: (noteId) ->
      NotesService.show(noteId).then (note) =>
        @body = aString(note.body)
        @citations = []
        note

    addCitation: (citation) ->
      a = @range(citation.range.start, citation.range.end)
        .pushAttr("citation_ids", citation.id)
        .addClass("highlight")
      @citations.push(citation)
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

    scope.createHighlight = (citation) ->
      NotesService.citation(noteId, citation).then (cit) ->
        scope.addCitation(cit)

    scope.getNote(noteId).then (note) ->
      for citation in note.citations
        scope.addCitation(citation)

    selectableBlock = new SelectableTextBlock(element.find("pre"))
    selectableBlock.select (range) ->
      scope.$apply ->
        scope.focusActiveHighlight(range.start, range.end)
        scope.clearSelection()

    element.on "mouseover", "span", (event) ->
      target = $(event.target)
      cits = $("#citations")
      offset = target.position()

      citations = (target.attr("citation_ids") || "").split(/\s+/)
      citations = for id in citations when id.length > 0
        parseInt id
      cits.css(
        top: offset.top
        position: "absolute"
      )
      scope.$apply ->
        active = for id in citations
          scope.getCitation(id)
        scope.setActiveCitations active

    element.on "mouseout", "span", (event) ->
      scope.$apply ->
        scope.clearActive()

    scope.setActiveCitations = (citations) ->
      scope.activeCitations = citations

    scope.clearActive = ->
      scope.activeCitations = []

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
