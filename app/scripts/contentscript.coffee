'use strict'

console.log('putting on glasses')

videos = document.getElementsByTagName("video")

console.log(videos)

startExtension = ()->
  console.log('Starting Extension')

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
