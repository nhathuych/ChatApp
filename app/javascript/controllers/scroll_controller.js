import { Controller } from "@hotwired/stimulus"

// turbo.hotwired.dev/reference/events
export default class extends Controller {

  initialize() {
    this.messageContainer = document.getElementById('js-messages')
    this.resetScrollWithoutThreshold(this.messageContainer)
  }

  // On start
  connect() {
    console.log('Connected')
    const self = this

    // scroll after a message sent
    this.messageContainer.addEventListener('DOMNodeInserted', function() {
      self.resetScroll(self.messageContainer)
    })
  }

  // On stop
  disconnect() {
    console.log('Disconnected')
  }

  // Custom function
  resetScroll(messageContainer) {
    const bottomOfScroll = messageContainer.scrollHeight - messageContainer.clientHeight
    const upperScrollThreshold = bottomOfScroll - 500

    // Scroll down if we're not within the threshold
    if (messageContainer.scrollTop > upperScrollThreshold) {
      this.resetScrollWithoutThreshold(messageContainer)
    }
  }

  resetScrollWithoutThreshold(messageContainer) {
    messageContainer.scrollTop = messageContainer.scrollHeight - messageContainer.clientHeight
  }
}
