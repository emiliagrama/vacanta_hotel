import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"
import { Romanian } from "flatpickr/dist/l10n/ro"




export default class extends Controller {
  static targets = ["package", "checkIn", "checkOut"];

  connect() {
    // Base flatpickr options (Romanian, DD.MM.YYYY, no mobile native)
    this.baseOptions = {
      dateFormat: "d.m.Y",
      disableMobile: true,
      minDate: "today",
      locale: Romanian,
    };

    this.checkInCalendar  = flatpickr(this.checkInTarget,  this.baseOptions);
    this.checkOutCalendar = flatpickr(this.checkOutTarget, this.baseOptions);

    // Default: checkout should not be user editable except "vrei tu"
    this.checkOutTarget.readOnly = true;
    this.checkOutCalendar.set("clickOpens", false);
  }

  disconnect() {
    // Clean up if the controller is removed
    if (this.checkInCalendar)  this.checkInCalendar.destroy();
    if (this.checkOutCalendar) this.checkOutCalendar.destroy();
  }

  // Helper: fully reset mode state so hooks/constraints don’t leak across modes
  resetCalendarsForNewMode() {
    // Clear selected dates
    this.checkInCalendar.clear();
    this.checkOutCalendar.clear();

    // Lock checkout by default; override only in "vrei tu"
    this.checkOutTarget.readOnly = true;
    this.checkOutCalendar.set("clickOpens", false);

    // IMPORTANT: wipe previous hooks so modes don’t stack
    this.checkInCalendar.set("onChange", []);
    this.checkOutCalendar.set("onChange", []);

    // Neutralize constraints left by other modes
    this.checkInCalendar.set("enable", []);        // all dates enabled
    this.checkOutCalendar.set("minDate", "today"); // reset min
  }

  updateDatePicker() {
    const value = (this.packageTarget.value || "").toLowerCase();

    // Always start from a clean slate before applying a mode
    this.resetCalendarsForNewMode();

    // Filters
    const mondayFilter  = (date) => date.getDay() === 1;      // Monday
    const weekendFilter = (date) => [5, 6].includes(date.getDay()); // Fri/Sat

    // Common “custom” options (used only for “vrei tu” re-init)
    const customOptions = {
      dateFormat: "d.m.Y",
      disableMobile: true,
      minDate: "today",
      locale: { firstDayOfWeek: 1 },
    };

    // 5 nights (Mon -> +5)
    if (value.includes("intens")) {
      this.checkInCalendar.set("enable", [mondayFilter]);
      this.checkInCalendar.set("onChange", ([checkIn]) => {
        if (!checkIn) return;
        const checkOut = new Date(checkIn);
        checkOut.setDate(checkOut.getDate() + 5);
        this.checkOutCalendar.setDate(checkOut, true);
      });

    // 10 nights (Mon -> +10)
    } else if (value.includes("prelungit")) {
      this.checkInCalendar.set("enable", [mondayFilter]);
      this.checkInCalendar.set("onChange", ([checkIn]) => {
        if (!checkIn) return;
        const checkOut = new Date(checkIn);
        checkOut.setDate(checkOut.getDate() + 10);
        this.checkOutCalendar.setDate(checkOut, true);
      });

    // Monday-only consultation (same-day checkout)
    } else if (value.includes("consult")) {
      this.checkInCalendar.set("enable", [mondayFilter]);
      this.checkInCalendar.set("onChange", ([checkIn]) => {
        if (!checkIn) return;
        // set to noon to avoid rare timezone day shifts
        const sameDay = new Date(
          checkIn.getFullYear(),
          checkIn.getMonth(),
          checkIn.getDate(),
          12
        );
        this.checkOutCalendar.setDate(sameDay, true);
      });

    // Weekend (Fri/Sat start -> +2 nights)
    } else if (value.includes("weekend")) {
      this.checkInCalendar.set("enable", [weekendFilter]);
      this.checkInCalendar.set("onChange", ([checkIn]) => {
        if (!checkIn) return;
        const checkOut = new Date(checkIn);
        checkOut.setDate(checkOut.getDate() + 2);
        this.checkOutCalendar.setDate(checkOut, true);
      });

    // Custom dates (“vrei tu”) – user chooses both; we re-init calendars
    } else if (value.includes("vrei tu")) {
      // Allow user to pick checkout; calendar should open on focus/click
      this.checkOutTarget.readOnly = false;
      this.checkOutCalendar.set("clickOpens", true);

      // Re-init both pickers with custom options
      this.checkInCalendar.destroy();
      this.checkOutCalendar.destroy();

      this.checkInCalendar = flatpickr(this.checkInTarget, {
        ...customOptions,
        onChange: ([checkIn]) => {
          if (!checkIn) return;
          // checkout cannot be before the next day
          const nextDay = new Date(checkIn);
          nextDay.setDate(checkIn.getDate() + 1);
          this.checkOutCalendar.set("minDate", nextDay);
        },
      });

      this.checkOutCalendar = flatpickr(this.checkOutTarget, customOptions);
    }
    // else: no selection -> keep defaults
  }
}
