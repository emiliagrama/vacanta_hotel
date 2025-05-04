import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Evită executarea în timpul unui preview Turbo
    if (document.documentElement.hasAttribute("data-turbo-preview")) return;

    this.images = this.element.querySelectorAll(".gallery-img")
    this.currentIndex = 0

    this.images.forEach((img, index) => {
      img.addEventListener("click", () => this.openFullscreen(index))
    })

    // Curăță suprapunerile la reîncărcarea paginii
    window.addEventListener("pageshow", () => {
      const existingOverlay = document.querySelector(".fullscreen-overlay")
      if (existingOverlay) existingOverlay.remove()
    })
  }

  openFullscreen(index) {
    this.currentIndex = index

    // Elimină suprapunerile existente
    const existingOverlay = document.querySelector(".fullscreen-overlay")
    if (existingOverlay) existingOverlay.remove()

    const overlay = document.createElement("div")
    overlay.classList.add("fullscreen-overlay")

    const img = this.images[index].cloneNode(true)
    img.classList.add("fullscreen", "fullscreen-img")
    img.removeAttribute("width")
    img.removeAttribute("height")
    img.style.width = "auto"
    img.style.height = "auto"
    img.style.maxWidth = "95vw"
    img.style.maxHeight = "95vh"
    img.style.margin = "2rem"
    img.style.boxShadow = "0 0 40px rgba(255, 255, 255, 0.26)"
    img.style.backgroundColor = "#1c1c1c"
    img.style.borderRadius = "10px"

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

    // Adaugă suport pentru swipe
    overlay.addEventListener("touchstart", this.handleTouchStart.bind(this), { passive: true })
    overlay.addEventListener("touchmove", this.handleTouchMove.bind(this), { passive: true })

    document.body.appendChild(overlay)
    this.currentOverlay = overlay

    // Blochează scroll-ul
    document.body.classList.add("no-scroll")
  }

  closeFullscreen(overlay) {
    overlay.remove()
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
}
