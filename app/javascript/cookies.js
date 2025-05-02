// --------------------
// 1. Cookie Functions
// --------------------
function setCookie(name, value, days) {
  const d = new Date();
  d.setTime(d.getTime() + (days * 24 * 60 * 60 * 1000));
  const expires = "expires=" + d.toUTCString();
  document.cookie = name + "=" + value + ";" + expires + ";path=/";
}

function getCookie(name) {
  const decodedCookies = decodeURIComponent(document.cookie);
  const cookieArray = decodedCookies.split(';');
  for (let i = 0; i < cookieArray.length; i++) {
    let cookie = cookieArray[i].trim();
    if (cookie.indexOf(name + "=") === 0) {
      return cookie.substring(name.length + 1);
    }
  }
  return "";
}

function deleteCookie(name) {
  document.cookie = name + '=; Max-Age=-99999999; path=/';
}

// --------------------
// 2. Set user status
// --------------------
function setUserStatus(status) {
  const current = getCookie("user_status");

  if (!current) {
    setCookie("user_status", status, 365);
    console.log("User status set to:", status);
  } else if (status === "client" && current !== "client") {
    setCookie("user_status", "client", 365);
    console.log("User upgraded to client.");
  } else {
    console.log("User status already set to:", current);
  }
}

function onBookRoom() {
  setUserStatus("client");
}

// --------------------
// 3. Cookie Banner + optional GA event
// --------------------
window.addEventListener("load", function () {
  const banner = document.getElementById("cookie-banner");
  const acceptBtn = document.getElementById("accept-cookies");
  const declineBtn = document.getElementById("decline-cookies");

  if (!getCookie("user_status") && banner) { // Show if no 'user_status' cookie is set
    banner.classList.add("visible");
  }

  if (acceptBtn) {
    acceptBtn.addEventListener("click", function () {
      if (getCookie("user_status") !== "client") {
        setUserStatus("curious");
      }

      banner.classList.remove("visible");

      const visitorType = getCookie("user_status");

      // Optional GA event for cookie acceptance
      if (typeof gtag === "function") {
        gtag("event", "cookie_consent", {
          event_category: "Consent",
          event_label: visitorType
        });
      }
    });
  }

  if (declineBtn) {
    declineBtn.addEventListener("click", function () {
      banner.classList.remove("visible");
    });
  }
});
// --------------------
// 4. Upgrade on Thank You page
// --------------------
document.addEventListener("DOMContentLoaded", function () {
  if (window.location.pathname.includes("/thank_you")) {
    if (getCookie("user_status") !== "client") {
      setCookie("user_status", "client", 365);
      console.log("✅ Cookie updated to client on thank_you page");
    } else {
      console.log("ℹ️ Already marked as client");
    }
  }
});
