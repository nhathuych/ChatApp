import consumer from "channels/consumer"

let resetFunction
let timer = 0

consumer.subscriptions.create("AppearanceChannel", {
  initialized() {
  },

  connected() {
    // Called when the subscription is ready for use on the server
    console.log('Connected')

    resetFunction = () => this.resetTimer()
    this.install()
    window.addEventListener('turbo:load', () => this.resetTimer())
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log('Disconnected')

    this.uninstall()
  },

  rejected() {
    console.log('Rejected')
    this.uninstall()
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
  },

  online() {
    console.log('online')
    this.perform('online')
  },
  offline() {
    console.log('offline')
    this.perform('offline')
  },
  away() {
    console.log('away')
    this.perform('away')
  },

  install() {
    console.log('install')
    window.removeEventListener('load', resetFunction)
    window.removeEventListener('DOMContentLoaded', resetFunction)
    window.removeEventListener('click', resetFunction)
    window.removeEventListener('keydown', resetFunction)

    window.addEventListener('load', resetFunction)
    window.addEventListener('DOMContentLoaded', resetFunction)
    window.addEventListener('click', resetFunction)
    window.addEventListener('keydown', resetFunction)

    this.resetTimer()
  },
  uninstall() {
    const hasAppearanceChannel = document.getElementById('js-appearance-channel')
    if (!hasAppearanceChannel) {
      clearTimeout(timer)
      this.perform('offline')
    }
  },

  resetTimer() {
    this.uninstall()
    const hasAppearanceChannel = document.getElementById('js-appearance-channel')

    if (!!hasAppearanceChannel) {
      this.online()
      clearTimeout(timer)
      timer = setTimeout(this.away.bind(this), 5000)
    }
  }
})
