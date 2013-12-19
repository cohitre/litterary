class TextSelection

class SelectableTextBlock
  constructor: (element) ->
    @element = element
    console.log @element

    @element.mouseup =>
      if @isSelectionInsideElement()
        console.log("1")

  isSelectionInsideElement: ->
    range = @selection().getRangeAt(0)
    index = $(range.commonAncestorContainer).parents().index($("pre"))
    return index >= 0

  selection: ->
    document.getSelection()

  select: (callback) ->
    @element.select (event) ->
      callback.call(this, event)

$ ->
  element = $("#highlightable")
  if element.length
    stb = new SelectableTextBlock(element)
    stb.select ->
      alert( "Handler for .select() called." )
