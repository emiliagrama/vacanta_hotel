import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"
import { Romanian } from "flatpickr/ro"
export default class extends Controller {
  static targets = ["package", "checkIn", "checkOut"]

  connect() {
    console.log("📅 Date Picker Controller Connected!")

    const options = {
      dateFormat: "d.m.Y",        // Day.Month.Year
      disableMobile: true,
      minDate: "today",
      locale: Romanian
    }

    this.checkInCalendar = flatpickr(this.checkInTarget, options)
    this.checkOutCalendar = flatpickr(this.checkOutTarget, options)
  }

  updateDatePicker() {
    // replace your current "const value = ..." with:
const value = (this.packageTarget.value ?? "")
  .trim()
  .normalize("NFD").replace(/\p{Diacritic}/gu, "")  // remove accents (ă → a, ț → t)
  .toLowerCase();

    this.checkOutTarget.readOnly = true
    this.checkOutCalendar.set("clickOpens", false)

    this.checkInCalendar.clear()
    this.checkOutCalendar.clear()

    const mondayFilter = date => date.getDay() === 1
    const weekendFilter = date => [5, 6].includes(date.getDay())

    const commonOptions = {
      dateFormat: "d.m.Y",
      disableMobile: true,
      minDate: "today",
      locale: { firstDayOfWeek: 1 }
    }

    if (value.includes("chibzuită")) {
      this.checkInCalendar.set("enable", [mondayFilter])
      this.checkInCalendar.set("onChange", ([checkIn]) => {
        if (checkIn) {
          const checkOut = new Date(checkIn)
          checkOut.setDate(checkOut.getDate() + 5)
          this.checkOutCalendar.setDate(checkOut, true)
        }
      })

    } else if (value.includes("săturate")) {
      this.checkInCalendar.set("enable", [mondayFilter])
      this.checkInCalendar.set("onChange", ([checkIn]) => {
        if (checkIn) {
          const checkOut = new Date(checkIn)
          checkOut.setDate(checkOut.getDate() + 10)
          this.checkOutCalendar.setDate(checkOut, true)
        }
      })

    } else if (value.includes("weekend")) {
      this.checkInCalendar.set("enable", [weekendFilter])
      this.checkInCalendar.set("onChange", ([checkIn]) => {
        if (checkIn) {
          const checkOut = new Date(checkIn)
          checkOut.setDate(checkOut.getDate() + 2)
          this.checkOutCalendar.setDate(checkOut, true)
        }
      })

    } else if (value.includes("vrei tu")) {
      this.checkOutTarget.readOnly = false
      this.checkOutCalendar.set("clickOpens", true)

      this.checkInCalendar.destroy()
      this.checkOutCalendar.destroy()

      this.checkInCalendar = flatpickr(this.checkInTarget, {
        ...commonOptions,
        onChange: ([checkIn]) => {
          if (checkIn) {
            const nextDay = new Date(checkIn)
            nextDay.setDate(checkIn.getDate() + 1)
            this.checkOutCalendar.set("minDate", nextDay)
          }
        }
      })

      this.checkOutCalendar = flatpickr(this.checkOutTarget, commonOptions)
    }
  }
}
