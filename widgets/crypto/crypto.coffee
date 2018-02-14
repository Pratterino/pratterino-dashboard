class Dashing.Crypto extends Dashing.Widget
  @accessor 'arrow', ->
    if parseInt(@get('crypto.change')) > 0 then 'fa fa-arrow-up' else 'fa fa-arrow-down'

  @accessor '', ->


  ready: ->
    # This is fired when the widget is done being rendered

  onData: (data) ->
    # Handle incoming data
    # You can access the html node of this widget with `@node`
    # Example: $(@node).fadeOut().fadeIn() will make the node flash each time data comes in.