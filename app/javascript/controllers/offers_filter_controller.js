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

    // Your old logic was inverted.
    // isCollapsed = true means panel is closed and should open.
    const isCollapsed = this.panelTarget.classList.contains("is-collapsed")
    const willOpen = isCollapsed

    this.panelTarget.classList.toggle("is-collapsed", !willOpen)
    this.arrowTarget.classList.toggle("is-open", willOpen)
    this.element.querySelector(".offers-filter__toggle")?.setAttribute("aria-expanded", String(willOpen))
  }

  reset() {
    Object.keys(this.state).forEach((k) => (this.state[k] = null))
    this.element.querySelectorAll(".filter-pill.is-active").forEach((b) => b.classList.remove("is-active"))

    // ✅ re-enable everything when reset
    this.setFiltersDisabled(false)
this.collapseAllDetails()
    this.apply()
  }
collapseAllDetails() {
  const scope = this.hasResultsTarget ? this.resultsTarget : this.element

  scope.querySelectorAll('[data-controller~="offer-details"]').forEach((el) => {
    const details = el.querySelector('[data-offer-details-target="details"]')
    const button = el.querySelector('[data-offer-details-target="button"]')

    if (details) details.classList.add("is-collapsed")
    if (button) {
      button.setAttribute("aria-expanded", "false")
      button.textContent = "Citește mai mult"
    }
  })
}
  select(e) {
    const btn = e.currentTarget
    const group = btn.dataset.group
    const value = btn.dataset.value
    const willClear = this.state[group] === value

    // clear active in this group
    this.element
      .querySelectorAll(`.filter-pill[data-group="${group}"]`)
      .forEach((b) => b.classList.remove("is-active"))

    if (willClear) {
      this.state[group] = null
    } else {
      this.state[group] = value
      btn.classList.add("is-active")
    }

    // ✅ if relaxare chosen, disable other groups + clear their state
    this.applyRelaxareLock()
this.collapseAllDetails()
    this.apply()
  }

  applyRelaxareLock() {
    const isRelaxare = this.state.vacanta === "relaxare"

    if (isRelaxare) {
      // clear other filters
      ;["people", "tratament", "nights", "meal"].forEach((k) => (this.state[k] = null))

      // clear active pills for other groups
      this.element
        .querySelectorAll('.filter-pill.is-active:not([data-group="vacanta"])')
        .forEach((b) => b.classList.remove("is-active"))
    }

    this.setFiltersDisabled(isRelaxare)
  }

  setFiltersDisabled(disabled) {
    // disable all pills except vacanta group
    this.element
      .querySelectorAll('.filter-pill:not([data-group="vacanta"])')
      .forEach((btn) => {
        btn.toggleAttribute("disabled", disabled)
        btn.classList.toggle("is-disabled", disabled)
        btn.setAttribute("aria-disabled", String(disabled))
      })
  }

  apply() {
    const scope = this.hasResultsTarget ? this.resultsTarget : this.element

    // ✅ IMPORTANT: don't touch BOOST cards (they usually have no data-vacanta)
    const cards = Array.from(scope.querySelectorAll('.offer-card[data-vacanta]'))

    let visible = 0

    const mealSelected = !!this.state.meal
    scope.classList.toggle("is-grid-mode", mealSelected)

    // 1) Hide/show cards
    cards.forEach((card) => {
      const isRelaxareSpecial = card.dataset.relaxareSpecial === "true"

     const ok = isRelaxareSpecial
  ? (this.state.vacanta === null || this.state.vacanta === "relaxare")
  : (
      this.match(card, "vacanta") &&
      this.match(card, "people") &&
      this.matchTratament(card) &&
      this.match(card, "nights") &&
      this.match(card, "meal")
    )

      card.classList.toggle("is-filter-hidden", !ok)
      if (ok) visible++
    })
    // 6) Relaxare section visibility
    const relaxSection = scope.querySelector(".offers-relaxare-section")

    if (relaxSection) {
      if (this.state.vacanta === "sanatate") {
        relaxSection.classList.add("is-filter-hidden")
      } else {
        relaxSection.classList.remove("is-filter-hidden")
      }
    }
    // 2) Hide empty rows
    scope.querySelectorAll(".offers-two-col-row").forEach((row) => {
      const rowCards = row.querySelectorAll('.offer-card[data-vacanta]')
      const anyVisible = Array.from(rowCards).some((c) => !c.classList.contains("is-filter-hidden"))
      row.classList.toggle("is-filter-hidden", !anyVisible)
    })

    // 3) Hide empty columns + mark single-column rows
    scope.querySelectorAll(".offers-two-col").forEach((col) => {
      const cardsInCol = Array.from(col.querySelectorAll('.offer-card[data-vacanta]'))
      const hasVisible = cardsInCol.some((c) => !c.classList.contains("is-filter-hidden"))
      col.classList.toggle("is-filter-hidden", !hasVisible)
    })

    scope.querySelectorAll(".offers-two-col-row").forEach((row) => {
      const visibleCols = Array.from(row.querySelectorAll(".offers-two-col")).filter(
        (col) => !col.classList.contains("is-filter-hidden")
      )
      row.classList.toggle("is-single", visibleCols.length === 1)
    })

    // 4) Program block hiding
    scope.querySelectorAll(".offers-program-block").forEach((block) => {
      const rows = block.querySelectorAll(".offers-two-col-row")
      const anyVisible = Array.from(rows).some((r) => !r.classList.contains("is-filter-hidden"))
      block.classList.toggle("is-filter-hidden", !anyVisible)
    })

    // 5) People block hiding (only if NOT relaxare)
    scope.querySelectorAll(".offers-people-block").forEach((block) => {
      const selectedPeople = this.state.people
      const isRelaxare = this.state.vacanta === "relaxare"

      if (isRelaxare) {
        block.classList.add("is-filter-hidden")
        return
      }

      const blockPeople = block.dataset.peopleBlock
      block.classList.toggle("is-filter-hidden", selectedPeople ? blockPeople !== selectedPeople : false)
    })

    // count label
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