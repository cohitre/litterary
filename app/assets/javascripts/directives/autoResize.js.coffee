angular.module("Litterary").directive "autoResize", ->
  (scope, element, attributes) ->
    t = element.get(0)
    offset = t.offsetHeight
    resize = ->
      t.style.height = "auto"
      if element.height() < t.scrollHeight
        t.style.height = t.scrollHeight + "px"

    element.bind "input", ->
      resize()
