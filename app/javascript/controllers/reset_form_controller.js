import { Controller } from "@hotwired/stimulus"

// turbo.hotwired.dev/reference/events
export default class extends Controller {
  reset() {
    this.element.reset()  // just a javascript function
  }
}
