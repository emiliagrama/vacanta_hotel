import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"

export default class extends Controller {
  static targets = ["package", "checkIn", "checkOut"]

  connect() {
    console.log("📅 Date Picker Controller Connected!")

    const options = {
      dateFormat: "Y-m-d",
      disableMobile: true,
      minDate: "today",
    }

    this.checkInCalendar = flatpickr(this.checkInTarget, options)
    this.checkOutCalendar = flatpickr(this.checkOutTarget, options)
  }

  updateDatePicker() {
    const value = this.packageTarget.value
    console.log("📦 Selected Package:", value)

    this.checkInCalendar.clear()
    this.checkOutCalendar.clear()

    const mondayFilter = (date) => date.getDay() === 1
    const weekendFilter = (date) => [5, 6, 0].includes(date.getDay()) // Fri/Sat/Sun


    if (value.includes("chibzuit")) {
      console.log("🧠 Chibzuit: only Mondays, +5 nights")

      this.checkInCalendar.set("enable", [mondayFilter])
      this.checkInCalendar.set("onChange", (selectedDates) => {
        const checkIn = selectedDates[0]
        if (checkIn) {
          const checkOut = new Date(checkIn)
          checkOut.setDate(checkOut.getDate() + 5)
          this.checkOutCalendar.setDate(checkOut, true)
          console.log("✅ Auto-filled chibzuit checkout:", checkOut.toISOString().slice(0, 10))
        }
      })

    } else if (value.includes("cinstit")) {
      console.log("💼 Cinstit: only Mondays, +10 nights")

      this.checkInCalendar.set("enable", [mondayFilter])
      this.checkInCalendar.set("onChange", (selectedDates) => {
        const checkIn = selectedDates[0]
        if (checkIn) {
          const checkOut = new Date(checkIn)
          checkOut.setDate(checkOut.getDate() + 10)
          this.checkOutCalendar.setDate(checkOut, true)
          console.log("✅ Auto-filled cinstit checkout:", checkOut.toISOString().slice(0, 10))
        }
      })

    } else if (value.includes("weekend")) {
      console.log("🍹 Weekend: only Fri/Sat/Sun, +2 nights")

      const weekendFilter = (date) => [5, 6, 0].includes(date.getDay()) // Fri, Sat, Sun
      this.checkInCalendar.set("enable", [weekendFilter])
      this.checkInCalendar.set("onChange", (selectedDates) => {
        const checkIn = selectedDates[0]
        if (checkIn) {
          const checkOut = new Date(checkIn)
          checkOut.setDate(checkOut.getDate() + 2)
          this.checkOutCalendar.setDate(checkOut, true)
          console.log("✅ Auto-filled weekend checkout:", checkOut.toISOString().slice(0, 10))
        }
      })

    } else if (value.includes("vrei tu")) {
      console.log("🌈 No restrictions (vacanța așa cum vrei tu)")

      // Destroy and fully reset both calendars
      this.checkInCalendar.destroy()
      this.checkOutCalendar.destroy()

      const options = {
        dateFormat: "Y-m-d",
        disableMobile: true,
        minDate: "today"
      }

      // Recreate clean calendars with no filters
      this.checkInCalendar = flatpickr(this.checkInTarget, {
        ...options,
        onChange: () => {} // clean callback
      })

      this.checkOutCalendar = flatpickr(this.checkOutTarget, {
        ...options
      })
    }


  }
}
