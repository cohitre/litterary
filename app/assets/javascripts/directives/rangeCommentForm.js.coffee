angular.module("Litterary").directive "rangeCommentForm", [->
  link: (scope, el) ->
    scope.$watch "citation", ->
      if scope.hasActiveHighlight()
        scope.positionCommentForm(scope, el)

    scope.submitComment = ->
      @createHighlight(scope.citation)
      @closeRangeComment()
    scope.cancelRangeComment = ->
      @closeRangeComment()
    scope.closeRangeComment = ->
      @blurActiveHighlight()
]
