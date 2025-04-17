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

    // Sensitivity threshold
    if (Math.abs(diffX) > 50) {
      if (diffX > 0) {
        // Swipe left → next
        this.showNext(this.currentOverlay)
      } else {
        // Swipe right → prev
        this.showPrev(this.currentOverlay)
      }

      this.startX = null // reset
    }
  }


  openFullscreen(index) {
    this.currentIndex = index

    const overlay = document.createElement("div")
    overlay.classList.add("fullscreen-overlay")

    // Clone the image
    const img = this.images[index].cloneNode(true)
    img.classList.add("fullscreen")

    // 💥 Force correct dimensions/styles
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

    // Close button
    const closeBtn = document.createElement("button")
    closeBtn.innerHTML = "×"
    closeBtn.classList.add("close-btn")
    closeBtn.addEventListener("click", () => overlay.remove())
    overlay.appendChild(closeBtn)

    // Left arrow
    const prev = document.createElement("div")
    prev.classList.add("gallery-arrow", "left")
    prev.innerHTML ="‹";
    prev.addEventListener("click", (e) => {
      e.stopPropagation()
      this.showPrev(overlay)
    })
    overlay.appendChild(prev)

    // Right arrow
    const next = document.createElement("div")
    next.classList.add("gallery-arrow", "right")
    next.innerHTML ="›";
    next.addEventListener("click", (e) => {
      e.stopPropagation()
      this.showNext(overlay)
    })
    overlay.appendChild(next)

    // Save overlay reference to use in swipe functions
this.currentOverlay = overlay

// Add touch listeners for swipe
overlay.addEventListener("touchstart", this.handleTouchStart.bind(this), { passive: true })
overlay.addEventListener("touchmove", this.handleTouchMove.bind(this), { passive: true })

document.body.appendChild(overlay)
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
