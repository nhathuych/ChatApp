import { Controller } from "@hotwired/stimulus"

// turbo.hotwired.dev/reference/events
export default class extends Controller {

  // On start
  connect() {
    console.log('Connected')
    const self = this
    const messageContainer = document.getElementById('js-messages')

    // scroll after a message sent
    messageContainer.addEventListener('DOMNodeInserted', function() {
      self.resetScroll(messageContainer)
    })

    this.resetScroll(messageContainer) // scroll by default
  }

  // On stop
  disconnect() {
    console.log('Disconnected')
  }

  // Custom function
  resetScroll(messageContainer) {
    messageContainer.scrollTop = messageContainer.scrollHeight - messageContainer.clientHeight
  }
}
