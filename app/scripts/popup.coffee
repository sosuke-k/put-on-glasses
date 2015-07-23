'use strict'

console.log('\'Allo \'Allo! Popup')

puton = ()->
  console.log("pushed")
  chrome.tabs.query({active: true, currentWindow: true}, (tabs)->
    console.log(tabs)
    chrome.tabs.sendMessage(tabs[0].id, {action: "start"}, (response)->
      console.log('Start action sent')
      console.log(response)
    )
  )

document.addEventListener("DOMContentLoaded", ()->
  document.getElementById("puton").addEventListener "click", puton
)
