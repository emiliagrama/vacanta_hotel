import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"

export default class extends Controller {
  static targets = ["package", "checkIn", "checkOut"]

  connect() {
    console.log("📅 Date Picker Controller Connected!")

    this.checkInCalendar = flatpickr(this.checkInTarget, {
      dateFormat: "Y-m-d",
      disableMobile: true,
      onChange: this.handleCheckInChange.bind(this),
    })

    this.checkOutCalendar = flatpickr(this.checkOutTarget, {
      dateFormat: "Y-m-d",
      disableMobile: true,
    })
  }

  updateDatePicker() {
    const value = this.packageTarget.value
    console.log("📦 Selected Package: ", value)

    // Reset calendars
    this.checkInCalendar.clear()
    this.checkOutCalendar.clear()
    this.checkInCalendar.set("enable", [])
    this.checkOutCalendar.set("enable", [])

    if (value.includes("Mini-Vacanță de weekend")) {
      console.log("🎯 Weekend package selected")

      const weekendFilter = (date) => {
        const day = date.getDay()
        return day === 5 || day === 6 || day === 0  // Friday, Saturday, Sunday
      }

      this.checkInCalendar.set("enable", [weekendFilter])
      this.checkOutCalendar.set("enable", [weekendFilter])

      this.checkInCalendar.set("onChange", (selectedDates) => {
        const checkIn = selectedDates[0]
        if (checkIn) {
          const checkOut = new Date(checkIn)
          checkOut.setDate(checkOut.getDate() + 2) // Weekend = 2-night stay
          this.checkOutCalendar.setDate(checkOut, true)
        }
      })

    } else if (value.includes("Vacanță cu tratament chibzuit")) {
      console.log("🧠 Monday only check-in + 5 day checkout");
      const mondayFilter = (date) => date.getDay() === 1;
      this.checkInCalendar.set("enable", [mondayFilter]);
      this.checkOutCalendar.set("enable", []);

      this.checkInCalendar.config.onChange = (selectedDates) => {
        const checkInDate = selectedDates[0];
        if (checkInDate) {
          const checkOutDate = new Date(checkInDate);
          checkOutDate.setDate(checkOutDate.getDate() + 5);
          this.checkOutCalendar.setDate(checkOutDate, true);
        }
      };

    } else if (value.includes("Vacanță cu tratament cinstit")) {
      console.log("📅 Monday only check-in + 10 day checkout");
      const mondayFilter = (date) => date.getDay() === 1;
      this.checkInCalendar.set("enable", [mondayFilter]);
      this.checkOutCalendar.set("enable", []);

      this.checkInCalendar.config.onChange = (selectedDates) => {
        const checkInDate = selectedDates[0];
        if (checkInDate) {
          const checkOutDate = new Date(checkInDate);
          checkOutDate.setDate(checkOutDate.getDate() + 10);
          this.checkOutCalendar.setDate(checkOutDate, true);
        }
      };



    } else if (value.includes("Vacanța, așa cum vrei tu")) {
      console.log("🎉 All dates allowed");
      this.checkInCalendar.set("enable", undefined);  // allow all
      this.checkOutCalendar.set("enable", undefined); // allow all
    }

  }

  handleCheckInChange(selectedDates) {
    // Placeholder — overwritten depending on selected package
  }
}
