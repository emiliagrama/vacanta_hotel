import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.images = this.element.querySelectorAll(".gallery-img")
    this.currentIndex = 0

    this.images.forEach((img, index) => {
      img.addEventListener("click", () => this.openFullscreen(index))
    })
  }

  handleTouchStart(e) {
    this.startX = e.touches[0].clientX
  }

  handleTouchMove(e) {
    if (!this.startX) return
    const diffX = this.startX - e.touches[0].clientX

    if (Math.abs(diffX) > 50) {
      if (diffX > 0) {
        this.showNext(this.currentOverlay)
      } else {
        this.showPrev(this.currentOverlay)
      }

      this.startX = null
    }
  }

  openFullscreen(index) {
    this.currentIndex = index

    const overlay = document.createElement("div")
    overlay.classList.add("fullscreen-overlay")

    const img = this.images[index].cloneNode(true)
    img.classList.add("fullscreen")
    img.removeAttribute("width")
    img.removeAttribute("height")
    img.style.width = "100vw"
    img.style.height = "100vh"
    img.style.objectFit = "contain"
    img.style.margin = "0"
    img.style.padding = "0"
    img.style.maxWidth = "none"
    img.style.maxHeight = "none"

    overlay.appendChild(img)

    const closeBtn = document.createElement("button")
    closeBtn.innerHTML = "×"
    closeBtn.classList.add("close-btn")
    closeBtn.addEventListener("click", () => this.closeFullscreen(overlay))
    overlay.appendChild(closeBtn)

    const prev = document.createElement("div")
    prev.classList.add("gallery-arrow", "left")
    prev.innerHTML = "‹"
    prev.addEventListener("click", (e) => {
      e.stopPropagation()
      this.showPrev(overlay)
    })
    overlay.appendChild(prev)

    const next = document.createElement("div")
    next.classList.add("gallery-arrow", "right")
    next.innerHTML = "›"
    next.addEventListener("click", (e) => {
      e.stopPropagation()
      this.showNext(overlay)
    })
    overlay.appendChild(next)

    // Add swipe
    overlay.addEventListener("touchstart", this.handleTouchStart.bind(this), { passive: true })
    overlay.addEventListener("touchmove", this.handleTouchMove.bind(this), { passive: true })

    document.body.appendChild(overlay)
    this.currentOverlay = overlay

    // 🔒 LOCK SCROLL
    document.body.classList.add("no-scroll")
  }

  closeFullscreen(overlay) {
    overlay.remove()

    // 🔓 UNLOCK SCROLL
    document.body.classList.remove("no-scroll")
  }

  showPrev(overlay) {
    this.currentIndex = (this.currentIndex - 1 + this.images.length) % this.images.length
    this.updateFullscreenImage(overlay)
  }

  showNext(overlay) {
    this.currentIndex = (this.currentIndex + 1) % this.images.length
    this.updateFullscreenImage(overlay)
  }

  updateFullscreenImage(overlay) {
    const img = overlay.querySelector(".fullscreen")
    img.src = this.images[this.currentIndex].src
    img.alt = this.images[this.currentIndex].alt
  }
}
