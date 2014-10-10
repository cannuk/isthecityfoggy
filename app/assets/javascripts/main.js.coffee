# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#= require kinetic-core
#= require cloudgen

class Fog
  createCloud: (height = 3, width = 15, x = 0, y = 0)->
    size = 23.7
    cloudCanvas = document.createElement "canvas"
    context = cloudCanvas.getContext("2d")
    cloudCanvas.width = width * (size)
    cloudCanvas.height = height * (size+20)
    grid = (((Math.round(Math.random())) for num in [0..width]) for num in [0..height])
    #stormy = {r: 190, g: 195, b:209}
    #mostly cloudy = {r: 239, g: 239, b:239}
    $cloudgen.drawCloudGroup(context, grid, 40, 40, 25, {r: 240, g: 240, b:240})
    new Kinetic.Image(image: cloudCanvas, x: x, y: y, opacity: 0)


  draw: ->
    layer = new Kinetic.Layer()
    cloudDensity = 20
    segmentSize = Math.floor(@width/cloudDensity)
    @drawCloud(layer, (Math.floor(Math.random()*(x*segmentSize))), (Math.floor(Math.random()*@height))) for x in [0..cloudDensity]

  drawCloud: (layer, x, y) ->
    cloud =  @createCloud(3, 15, x, y)
    @windSpeed = .8
#    @windSpeed += @windModifier
    cloudWidth = cloud.getWidth()
    layer.add(cloud)
    @stage.add(layer)
    cloud.transitionTo
      opacity: 1
      duration: 3
    anim = new Kinetic.Animation
      func: (frame) =>
        pos = cloud.getX() - @windSpeed
        if (cloud.getX() + cloudWidth) <= 0
          pos = @stage.getWidth() + 10
          #reset the y pos too, for cloud randomness
          cloud.setY(y)
        cloud.setX(pos)
      node: layer
    anim.start()

  render: ->

    isFoggy = $("h1").first()
    if isFoggy.text().toLowerCase() is "yes" or isFoggy.text().toLowerCase() is "probably"
      $("body").addClass("fog")
      $el = $(".fog-top")
      $sky = $(".sky")
      @width = $el.width()
      @height = $el.height()
      @stage = new Kinetic.Stage(container: $el.get(0), width: @width, height: @height)
      $el.css("marginTop", (($el.height()*.80)*-1))
      @draw()

  $ (=>

    fog = new Fog()
    fog.render()

  )
