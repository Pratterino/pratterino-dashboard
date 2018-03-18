class Dashing.Nyheter extends Dashing.Widget
  can = 0;
  ctx = 0;
  step = 0;
  steps = 0;
  delay = 20;

  constructor: ->
    can = document.getElementById "MyCanvas1"
    if can != null
      ctx = can.getContext "2d"
      ctx.fillStyle = "blue"
      ctx.font = "20pt Verdana"
      ctx.textAlign = "center"
      ctx.textBaseline = "middle"
      step = 0
      steps = can.width + 50
      RunTextLeftToRight()

  RunTextLeftToRight = ->
    step = step + 1
    ctx.clearRect(0, 0, can.width, can.height);
    ctx.save();
    ctx.translate step, can.height / 2;
    ctx.fillText "Welcome", 0, 0;
    ctx.restore();

    step = 0 if step == steps
    t = setTimeout('RunTextLeftToRight()', delay) if step < steps