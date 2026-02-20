import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    text: String,
    speed: { type: Number, default: 28 },      // ms per char
    startDelay: { type: Number, default: 0 },  // ms
  }

  connect() {
    // Respect reduced motion
    if (window.matchMedia?.("(prefers-reduced-motion: reduce)")?.matches) {
      this.element.textContent = this.textValue || ""
      return
    }

    this._fullText = this.textValue || ""
    this._i = 0
    this.element.textContent = ""

    // Prevent double-running if Turbo caches and reconnects
    this._alreadyRan = this.element.dataset.typewriterRan === "true"
    if (this._alreadyRan) return
    this.element.dataset.typewriterRan = "true"

    this._timeout = setTimeout(() => this._tick(), this.startDelayValue)
  }

  disconnect() {
    clearTimeout(this._timeout)
  }

  _tick() {
    // Safety
    if (!this._fullText) return

    this.element.textContent = this._fullText.slice(0, this._i + 1)
    this._i += 1

    if (this._i < this._fullText.length) {
      this._timeout = setTimeout(() => this._tick(), this.speedValue)
    }
  }
}
