angular.module("Litterary").directive "rangeCommentForm", ["NoteCitationsService", (NoteCitationsService) ->
  link: (scope, el) ->
    scope.submitComment = ->
      NoteCitationsService.create(scope.note.id, scope.citation).then (result) ->
        scope.highlight(result)
      @closeRangeComment()
    scope.cancelRangeComment = ->
      @closeRangeComment()
    scope.closeRangeComment = ->
      @clearCitation()
]
