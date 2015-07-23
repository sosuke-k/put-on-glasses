'use strict'

startExtension = ()->
  console.log('Starting Extension')
  console.log('putting on glasses')

  videos = document.getElementsByTagName("video")
  console.log(videos)
  v = videos[0]
  rect = v.getBoundingClientRect()

  canvas = document.createElement("canvas")
  backcvs = document.createElement("canvas")
  canvas.id = "canvasVideoCvs"
  backcvs.id = "canvasVideoBcvs"
  canvas.setAttribute("width", rect.width)
  canvas.setAttribute("height", rect.height)
  backcvs.setAttribute("width", rect.width)
  backcvs.setAttribute("height", rect.height)

  canvas.style.position = "relative"
  backcvs.style.display = "none"

  p = v.parentElement
  p.appendChild(canvas)
  p.appendChild(backcvs)

  # v.style.display = "none"

  drawBlackWhiteFrame()

drawBlackWhiteFrame = ()->

  canvas = document.getElementById('canvasVideoCvs')
  backcvs = document.getElementById('canvasVideoBcvs')
  ctx = canvas.getContext('2d')
  bcv = backcvs.getContext('2d')
  w = canvas.width
  h = canvas.height

  video = document.getElementsByTagName("video")[0]
  bcv.drawImage(video, 0, 0, w, h)
  apx = bcv.getImageData(0, 0, w, h)
  data = apx.data

  for i in [0..data.length]
    r = data[i]
    g = data[i+1]
    b = data[i+2]
    gray = (r+g+b)/3
    data[i] = gray
    data[i+1] = gray
    data[i+2] = gray

  # apx.data = data
  ctx.putImageData(apx, 0, 0)

  if video.paused || video.ended
    return

  setTimeout( ()->
    drawBlackWhiteFrame()
  , 0)



stopExtension = ()->
  console.log('Stopping Extension')

onRequest = (request, sender, sendResponse)->
  console.log('onRequest')
  if (request.action == 'start')
    startExtension()
  else if (request.action == 'stop')
    stopExtension()
  sendResponse({})

chrome.runtime.onMessage.addListener(onRequest)
