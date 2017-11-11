class Dashing.lastfm extends Dashing.Widget

  ready: ->
    status = $(@node).find('p.status')
    if status.html() == 'ok'
      status.remove()

  onData: (data) ->
    $('.lastfm-bg', @node).css('background-image', "url(#{data.cover})")
