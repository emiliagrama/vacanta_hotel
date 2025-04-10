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
    // Only upgrade from curious to client
    setCookie("user_status", "client", 365);
    console.log("User upgraded to client.");
  } else {
    console.log("User status already set to:", current);
  }
}

// --------------------
// 3. Cookie banner logic
// --------------------
window.addEventListener("load", function () {
  console.log("Window loaded, checking user status cookie...");

  const banner = document.getElementById("cookie-banner");
  const acceptBtn = document.getElementById("accept-cookies");
  const declineBtn = document.getElementById("decline-cookies");

  if (!getCookie("user_status")) {
    banner.classList.add("visible");
  }

  if (acceptBtn) {
    acceptBtn.addEventListener("click", function () {
      const current = getCookie("user_status");

      if (current !== "client") {
        setUserStatus("curious"); // Only set curious if not already client
      }

      banner.classList.remove("visible");
    });
  }

  if (declineBtn) {
    declineBtn.addEventListener("click", function () {
      banner.classList.remove("visible");
    });
  }
});

// --------------------
// 4. Call when user books
// --------------------
function onBookRoom() {
  setUserStatus("client");
}
