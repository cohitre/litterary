angular.module("Litterary").directive "rangeCommentForm", ["NoteCitationsService", (NoteCitationsService) ->
  link: (scope, el) ->
    scope.$watch "citation", ->
      if scope.hasActiveHighlight()
        scope.positionCommentForm(scope, el)

    scope.submitComment = ->
      NoteCitationsService.create(scope.note.id, scope.citation).then (result) ->
        scope.highlight(result)
      @closeRangeComment()
    scope.cancelRangeComment = ->
      @closeRangeComment()
    scope.closeRangeComment = ->
      @blurActiveHighlight()
]
