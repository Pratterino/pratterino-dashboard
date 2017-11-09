class Dashing.Instagram extends Dashing.Widget

  onData: (data) ->
    console.info(data)

    $('.instagram__pic', @node).css('background-image', "url(#{data.instagram.url})")
    console.info($('.instagram__pic', @node))

    # Handle incoming data
    # You can access the html node of this widget with `@node`
