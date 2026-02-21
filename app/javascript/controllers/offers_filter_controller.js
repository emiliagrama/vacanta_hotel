import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "arrow", "count", "results"]

  connect() {
    this.state = {
      vacanta: null,
      people: null,
      tratament: null,
      nights: null,
      meal: null
    }

    this.apply()
  }

  toggle(e) {
    e.preventDefault()
    const open = this.panelTarget.classList.contains("is-collapsed")
    this.panelTarget.classList.toggle("is-collapsed", !open)
    this.arrowTarget.classList.toggle("is-open", open)
    this.element.querySelector(".offers-filter__toggle")?.setAttribute("aria-expanded", String(open))
  }

  reset() {
    Object.keys(this.state).forEach((k) => (this.state[k] = null))
    this.element.querySelectorAll(".filter-pill.is-active").forEach((b) => b.classList.remove("is-active"))
    this.apply()
  }

  select(e) {
    const btn = e.currentTarget
    const group = btn.dataset.group
    const value = btn.dataset.value
    const willClear = this.state[group] === value

    this.element.querySelectorAll(`.filter-pill[data-group="${group}"]`).forEach((b) => b.classList.remove("is-active"))

    if (willClear) {
      this.state[group] = null
    } else {
      this.state[group] = value
      btn.classList.add("is-active")
    }

    this.apply()
  }
apply() {
  const scope = this.hasResultsTarget ? this.resultsTarget : this.element
  const cards = Array.from(scope.querySelectorAll(".offer-card"))
  let visible = 0
const mealSelected = !!this.state.meal
scope.classList.toggle("is-grid-mode", mealSelected)
  // 1) Hide/show cards
  cards.forEach((card) => {
    const ok =
      this.match(card, "vacanta") &&
      this.match(card, "people") &&
      this.matchTratament(card) &&
      this.match(card, "nights") &&
      this.match(card, "meal")

    card.classList.toggle("is-filter-hidden", !ok)
    if (ok) visible++
  })

  // 2) Hide empty rows (you already have this)
  scope.querySelectorAll(".offers-two-col-row").forEach((row) => {
    const rowCards = row.querySelectorAll(".offer-card")
    const anyVisible = Array.from(rowCards).some((c) => !c.classList.contains("is-filter-hidden"))
    row.classList.toggle("is-filter-hidden", !anyVisible)
  })

  // ✅ ADD THIS BLOCK HERE
  // 3) Hide empty columns + mark single-column rows
  scope.querySelectorAll(".offers-two-col").forEach((col) => {
    const cardsInCol = Array.from(col.querySelectorAll(".offer-card"))
    const hasVisible = cardsInCol.some((c) => !c.classList.contains("is-filter-hidden"))
    col.classList.toggle("is-filter-hidden", !hasVisible)
  })

  scope.querySelectorAll(".offers-two-col-row").forEach((row) => {
    const visibleCols = Array.from(row.querySelectorAll(".offers-two-col")).filter(
      (col) => !col.classList.contains("is-filter-hidden")
    )
    row.classList.toggle("is-single", visibleCols.length === 1)
  })
  // ✅ END ADD

  // 4) Program block hiding (you already have this)
  scope.querySelectorAll(".offers-program-block").forEach((block) => {
    const rows = block.querySelectorAll(".offers-two-col-row")
    const anyVisible = Array.from(rows).some((r) => !r.classList.contains("is-filter-hidden"))
    block.classList.toggle("is-filter-hidden", !anyVisible)
  })

  // 5) People block hiding (you already have this)
  scope.querySelectorAll(".offers-people-block").forEach((block) => {
    const blockPeople = block.dataset.peopleBlock
    const selected = this.state.people
    block.classList.toggle("is-filter-hidden", selected ? blockPeople !== selected : false)
  })

  this.countTarget.textContent =
    visible === cards.length ? "Toate ofertele" : `${visible} oferte disponibile`
}

  match(card, group) {
    const val = this.state[group]
    if (!val) return true

    switch (group) {
      case "vacanta":
        return card.dataset.vacanta === val
      case "people":
        return card.dataset.people === val
      case "nights":
        return card.dataset.nights === val
      case "meal":
        return card.dataset.meal === val
      default:
        return true
    }
  }

  matchTratament(card) {
    const selected = this.state.tratament
    if (!selected) return true

    const t = card.dataset.tratament
    if (t === selected) return true
    if (t === "balnear_ozon" && (selected === "balnear" || selected === "ozon")) return true
    return false
  }
}