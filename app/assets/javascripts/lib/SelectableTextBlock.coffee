textLengthBeforeElement = (el) ->
  length = 0
  while el = el.previousSibling
    length += el.textContent.length
  length

closestSpan = (element) ->
  if element.nodeType == document.TEXT_NODE
    element = element.parentElement
  element

class @SelectableTextBlock
  constructor: (@element) ->
    @element.mouseup (ev) =>
      if @isSelected()
        event = jQuery.Event("textselect")
        event.range = @getRange()
        event.clientX = ev.clientX
        event.clientY = ev.clientY
        @element.trigger event

  isSelected: ->
    range = document.getSelection().getRangeAt(0)
    if range.commonAncestorContainer == @element.get(0)
      return !range.collapsed
    else
      index = $(range.commonAncestorContainer).parents().index(@element)
      return !range.collapsed && index >= 0

  getRange: ->
    range = document.getSelection().getRangeAt(0)
    startOffset = textLengthBeforeElement(closestSpan(range.startContainer)) + range.startOffset
    endOffset = textLengthBeforeElement(closestSpan(range.endContainer)) + range.endOffset

    return {
      start: startOffset
      end: endOffset
    }

  select: (callback) ->
    @element.bind "textselect", (event) ->
      callback.call(this, event.range)

  getNodeForIndex: (offset) ->
    rangeEnd = 0
    if offset == 0
      @element.children().first()
    else
      @element.children().filter ->
        rangeStart = rangeEnd
        rangeEnd = rangeEnd + $(this).text().length
        return rangeStart < offset && rangeEnd >= offset

  split: (index) ->
    firstHalf = @getNodeForIndex(index).first()
    secondHalf = firstHalf.clone()

    nodeOffset = index - textLengthBeforeElement(firstHalf.get(0))
    text = firstHalf.text()
    firstHalf.text text.slice(0, nodeOffset)
    secondHalf.text text.slice(nodeOffset)

    firstHalf.after(secondHalf)
    return firstHalf

  addAttribute: (start, end, attributes) ->
    startSpan = @split(start)
    endSpan = @split(end)
    return startSpan
      .first().nextAll()
      .not(endSpan.first().nextAll())
      .css(attributes)

