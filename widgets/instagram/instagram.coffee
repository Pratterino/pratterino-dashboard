class Dashing.Instagram extends Dashing.Widget

  onData: (data) ->
    $('.instagram__pic', @node).css('background-image', "url(#{data.instagram.url})")