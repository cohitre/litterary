angular.module("Litterary").directive "highlightable", ["$compile", ($compile) ->
  (scope, element) ->

    stb = new SelectableTextBlock(element)
    stb.select (range) ->
      scope.$apply ->
        if scope.isCommentable()
          scope.noteString.range(range.start, range.end).addClass("highlight")
          scope.refresh()
          commentContainer = scope.getQueryRangeCommentArea(range.start, range.end)
          document.getSelection().removeAllRanges()
    scope.refresh = ->
      if scope.noteString?
        element.html scope.noteString.toHtml()

    scope.addClass = (start, end, klass) ->
      scope.noteString.range(start, end).addClass klass

    scope.refresh()
]
