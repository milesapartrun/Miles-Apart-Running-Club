/* =========================================================
   MILES APART
   UNIVERSAL PROFILE MODAL
   =========================================================

   Diese Datei sorgt dafür, dass "My Profile" auf ALLEN
   Unterseiten ein Popup öffnet.

   Benötigte Supabase-Profilfelder:
   - display_name
   - username
   - avatar_url
   - bio
   - location

   Zusätzlich wird die E-Mail aus dem Supabase-User geladen.
========================================================= */

(function () {

  "use strict";


  /* =======================================================
     CSS FÜR DAS PROFIL-POPUP
  ======================================================= */

  const style = document.createElement("style");

  style.textContent = `

    /* =====================================================
       PROFILE MODAL OVERLAY
    ===================================================== */

    .miles-profile-overlay {

      position: fixed;

      inset: 0;

      z-index: 1000;

      display: none;

      align-items: center;

      justify-content: center;

      padding: 20px;

      box-sizing: border-box;

      background: rgba(0, 0, 0, .55);

      overflow-y: auto;

    }


    .miles-profile-overlay.open {

      display: flex;

    }


    /* =====================================================
       PROFILE MODAL
    ===================================================== */

    .miles-profile-modal {

      position: relative;

      width: min(560px, 100%);

      max-height: calc(100vh - 40px);

      overflow-y: auto;

      background: #fff;

      border: 1px solid #ddd;

      box-shadow:
        0 25px 80px rgba(0,0,0,.25);

    }


    /* =====================================================
       CLOSE BUTTON
    ===================================================== */

    .miles-profile-close {

      position: absolute;

      top: 14px;

      right: 16px;

      z-index: 5;

      width: 38px;

      height: 38px;

      border: 0;

      border-radius: 50%;

      background: rgba(255,255,255,.95);

      color: #555;

      font-size: 28px;

      line-height: 1;

      cursor: pointer;

      display: flex;

      align-items: center;

      justify-content: center;

      transition: .2s ease;

    }


    .miles-profile-close:hover {

      color: var(--miles-blue, #18b8c7);

      transform: scale(1.05);

    }


    /* =====================================================
       COVER
    ===================================================== */

    .miles-profile-cover {

      height: 135px;

      background:
        linear-gradient(
          135deg,
          var(--miles-blue, #18b8c7),
          #0f8995
        );

    }


    /* =====================================================
       BODY
    ===================================================== */

    .miles-profile-body {

      padding: 0 36px 36px;

    }


    /* =====================================================
       AVATAR
    ===================================================== */

    .miles-profile-avatar {

      width: 108px;

      height: 108px;

      margin-top: -54px;

      border: 4px solid #fff;

      border-radius: 50%;

      overflow: hidden;

      box-sizing: border-box;

      background: #f5f5f3;

      color: var(--miles-blue, #18b8c7);

      display: flex;

      align-items: center;

      justify-content: center;

      font-size: 34px;

      font-weight: 700;

      box-shadow:
        0 8px 25px rgba(0,0,0,.12);

    }


    .miles-profile-avatar img {

      width: 100%;

      height: 100%;

      object-fit: cover;

      display: block;

    }


    /* =====================================================
       HEADER
    ===================================================== */

    .miles-profile-kicker {

      margin-top: 20px;

      color: var(--miles-blue, #18b8c7);

      font-size: 10px;

      line-height: 1;

      font-weight: 700;

      letter-spacing: 2px;

      text-transform: uppercase;

    }


    .miles-profile-name {

      margin: 7px 0 0;

      color: #111;

      font-size: 36px;

      line-height: .98;

      letter-spacing: -1.5px;

      font-weight: 700;

    }


    .miles-profile-username {

      margin-top: 9px;

      color: #888;

      font-size: 13px;

      line-height: 1.4;

    }


    /* =====================================================
       INFO GRID
    ===================================================== */

    .miles-profile-grid {

      display: grid;

      grid-template-columns:
        1fr 1fr;

      gap: 12px;

      margin-top: 28px;

    }


    .miles-profile-info {

      padding: 16px;

      background: #f7f7f5;

      border: 1px solid #e4e4e0;

      box-sizing: border-box;

    }


    .miles-profile-info.full {

      grid-column: 1 / -1;

    }


    .miles-profile-label {

      margin-bottom: 7px;

      color: #999;

      font-size: 9px;

      line-height: 1;

      letter-spacing: 1.5px;

      text-transform: uppercase;

      font-weight: 700;

    }


    .miles-profile-value {

      color: #222;

      font-size: 14px;

      line-height: 1.55;

      word-break: break-word;

    }


    .miles-profile-value.muted {

      color: #999;

    }


    /* =====================================================
       FOOTER
    ===================================================== */

    .miles-profile-footer {

      margin-top: 24px;

      display: flex;

      gap: 10px;

    }


    .miles-profile-button {

      width: 100%;

      min-height: 46px;

      padding: 12px 18px;

      border: 1px solid #d7d7d3;

      background: #fff;

      color: #222;

      font-size: 11px;

      letter-spacing: 1px;

      text-transform: uppercase;

      cursor: pointer;

      transition: .2s ease;

    }


    .miles-profile-button:hover {

      border-color:
        var(--miles-blue, #18b8c7);

      color:
        var(--miles-blue, #18b8c7);

    }


    /* =====================================================
       MOBILE
    ===================================================== */

    @media (max-width: 600px) {

      .miles-profile-overlay {

        padding: 12px;

      }


      .miles-profile-modal {

        max-height:
          calc(100vh - 24px);

      }


      .miles-profile-cover {

        height: 105px;

      }


      .miles-profile-body {

        padding:
          0 22px 24px;

      }


      .miles-profile-avatar {

        width: 94px;

        height: 94px;

        margin-top: -47px;

        font-size: 29px;

      }


      .miles-profile-name {

        font-size: 30px;

      }


      .miles-profile-grid {

        grid-template-columns: 1fr;

      }


      .miles-profile-info.full {

        grid-column: auto;

      }


      .miles-profile-footer {

        flex-direction: column;

      }

    }

  `;

  document.head.appendChild(style);


  /* =======================================================
     HILFSFUNKTIONEN
  ======================================================= */

  function escapeHtml(value) {

    return String(value ?? "")

      .replace(/&/g, "&amp;")

      .replace(/</g, "&lt;")

      .replace(/>/g, "&gt;")

      .replace(/"/g, "&quot;")

      .replace(/'/g, "&#039;");

  }


  function getInitials(name) {

    if (!name) {

      return "M";

    }


    const parts =
      String(name)
        .trim()
        .split(/\s+/)
        .filter(Boolean);


    if (parts.length === 1) {

      return parts[0]
        .substring(0, 1)
        .toUpperCase();

    }


    return (

      parts[0].substring(0, 1) +

      parts[parts.length - 1]
        .substring(0, 1)

    ).toUpperCase();

  }


  function getDisplayName(
    user,
    profile
  ) {

    if (
      profile &&
      profile.display_name &&
      String(profile.display_name).trim()
    ) {

      return String(
        profile.display_name
      ).trim();

    }


    if (
      user &&
      user.user_metadata &&
      user.user_metadata.display_name
    ) {

      return String(
        user.user_metadata.display_name
      ).trim();

    }


    if (
      user &&
      user.user_metadata &&
      user.user_metadata.name
    ) {

      return String(
        user.user_metadata.name
      ).trim();

    }


    if (
      user &&
      user.email
    ) {

      return user.email
        .split("@")[0]
        .trim();

    }


    return "Runner";

  }


  /* =======================================================
     MODAL ERSTELLEN
  ======================================================= */

  function createProfileModal() {

    if (
      document.getElementById(
        "milesProfileOverlay"
      )
    ) {

      return;

    }


    const overlay =
      document.createElement("div");


    overlay.id =
      "milesProfileOverlay";


    overlay.className =
      "miles-profile-overlay";


    overlay.innerHTML = `

      <div
        class="miles-profile-modal"
        role="dialog"
        aria-modal="true"
        aria-labelledby="milesProfileName"
      >

        <button
          class="miles-profile-close"
          id="milesProfileClose"
          type="button"
          aria-label="Profil schließen"
        >
          ×
        </button>


        <div
          class="miles-profile-cover"
        ></div>


        <div
          class="miles-profile-body"
        >


          <div
            class="miles-profile-avatar"
            id="milesProfileAvatar"
          >
            M
          </div>


          <div
            class="miles-profile-kicker"
          >
            MY PROFILE
          </div>


          <h2
            class="miles-profile-name"
            id="milesProfileName"
          >
            Runner
          </h2>


          <div
            class="miles-profile-username"
            id="milesProfileUsername"
          ></div>


          <div
            class="miles-profile-grid"
          >


            <div
              class="miles-profile-info"
            >

              <div
                class="miles-profile-label"
              >
                E-Mail
              </div>

              <div
                class="miles-profile-value"
                id="milesProfileEmail"
              >
                —
              </div>

            </div>


            <div
              class="miles-profile-info"
            >

              <div
                class="miles-profile-label"
              >
                Standort
              </div>

              <div
                class="miles-profile-value"
                id="milesProfileLocation"
              >
                —
              </div>

            </div>


            <div
              class="miles-profile-info full"
            >

              <div
                class="miles-profile-label"
              >
                Über mich
              </div>

              <div
                class="miles-profile-value"
                id="milesProfileBio"
              >
                Noch keine Bio hinterlegt.
              </div>

            </div>


          </div>


          <div
            class="miles-profile-footer"
          >

            <button
              class="miles-profile-button"
              id="milesProfileCloseBottom"
              type="button"
            >
              Schließen
            </button>

          </div>


        </div>

      </div>

    `;


    document.body.appendChild(
      overlay
    );


    /* =====================================================
       SCHLIESSEN
    ===================================================== */

    function closeProfileModal() {

      overlay.classList.remove(
        "open"
      );

      document.body.style.overflow =
        "";

    }


    document
      .getElementById(
        "milesProfileClose"
      )
      .addEventListener(
        "click",
        closeProfileModal
      );


    document
      .getElementById(
        "milesProfileCloseBottom"
      )
      .addEventListener(
        "click",
        closeProfileModal
      );


    overlay.addEventListener(
      "click",
      function(event) {

        if (
          event.target === overlay
        ) {

          closeProfileModal();

        }

      }
    );


    document.addEventListener(
      "keydown",
      function(event) {

        if (
          event.key === "Escape" &&
          overlay.classList.contains(
            "open"
          )
        ) {

          closeProfileModal();

        }

      }
    );


    /* =====================================================
       GLOBAL FUNKTION ZUM ÖFFNEN
    ===================================================== */

    window.milesApartProfileModal = {

      open: function(
        user,
        profile
      ) {

        const displayName =
          getDisplayName(
            user,
            profile
          );


        const avatar =
          document.getElementById(
            "milesProfileAvatar"
          );


        const name =
          document.getElementById(
            "milesProfileName"
          );


        const username =
          document.getElementById(
            "milesProfileUsername"
          );


        const email =
          document.getElementById(
            "milesProfileEmail"
          );


        const location =
          document.getElementById(
            "milesProfileLocation"
          );


        const bio =
          document.getElementById(
            "milesProfileBio"
          );


        /* Name */

        name.textContent =
          displayName;


        /* Username */

        if (
          profile &&
          profile.username
        ) {

          username.textContent =
            "@" +
            profile.username;

        } else {

          username.textContent =
            "";

        }


        /* E-Mail */

        email.textContent =
          user &&
          user.email
            ? user.email
            : "—";


        /* Standort */

        if (
          profile &&
          profile.location
        ) {

          location.textContent =
            profile.location;

          location.classList.remove(
            "muted"
          );

        } else {

          location.textContent =
            "Noch nicht angegeben";

          location.classList.add(
            "muted"
          );

        }


        /* Bio */

        if (
          profile &&
          profile.bio
        ) {

          bio.textContent =
            profile.bio;

          bio.classList.remove(
            "muted"
          );

        } else {

          bio.textContent =
            "Noch keine Bio hinterlegt.";

          bio.classList.add(
            "muted"
          );

        }


        /* Avatar */

        avatar.innerHTML =
          "";


        if (
          profile &&
          profile.avatar_url
        ) {

          const image =
            document.createElement(
              "img"
            );


          image.src =
            profile.avatar_url;


          image.alt =
            displayName;


          avatar.appendChild(
            image
          );

        } else {

          avatar.textContent =
            getInitials(
              displayName
            );

        }


        /* Modal öffnen */

        overlay.classList.add(
          "open"
        );


        document.body.style.overflow =
          "hidden";

      }

    };

  }


  /* =======================================================
     SUPABASE CLIENT
  ======================================================= */

  let supabaseClient = null;


  window.milesApartSetSupabaseClient =
    function(client) {

      supabaseClient =
        client;

      bindProfileLinks();

    };


  /* =======================================================
     PROFIL LADEN
  ======================================================= */

  async function getCurrentProfile(
    user
  ) {

    if (
      !supabaseClient ||
      !user
    ) {

      return null;

    }


    try {

      const {
        data,
        error
      } =
        await supabaseClient

          .from("profiles")

          .select(
            "display_name, username, avatar_url, bio, location"
          )

          .eq(
            "id",
            user.id
          )

          .maybeSingle();


      if (error) {

        console.error(
          "Profil konnte nicht geladen werden:",
          error
        );

        return null;

      }


      return data || null;

    } catch (error) {

      console.error(
        "Profil konnte nicht geladen werden:",
        error
      );

      return null;

    }

  }


  /* =======================================================
     MY PROFILE LINKS AUF ALLEN SEITEN ABFANGEN
  ======================================================= */

  function bindProfileLinks() {

    const elements =
      document.querySelectorAll(
        'a[href*="#myRunSection"], [data-profile-link]'
      );


    elements.forEach(
      function(element) {

        if (
          element.dataset.profileModalBound ===
          "true"
        ) {

          return;

        }


        element.dataset.profileModalBound =
          "true";


        element.addEventListener(
          "click",
          async function(event) {

            event.preventDefault();


            /* Noch nicht eingeloggt */

            if (
              !supabaseClient
            ) {

              console.error(
                "Supabase Client wurde noch nicht gesetzt."
              );

              return;

            }


            const {
              data,
              error
            } =
              await supabaseClient
                .auth
                .getSession();


            if (error) {

              console.error(
                "Session konnte nicht geladen werden:",
                error
              );

              return;

            }


            const session =
              data &&
              data.session;


            const user =
              session &&
              session.user;


            if (!user) {

              /*
                Falls jemand auf My Profile klickt,
                obwohl er ausgeloggt ist.
              */

              if (
                typeof window.openAuth ===
                "function"
              ) {

                window.openAuth();

              }

              return;

            }


            const profile =
              await getCurrentProfile(
                user
              );


            if (
              window.milesApartProfileModal
            ) {

              window.milesApartProfileModal
                .open(
                  user,
                  profile
                );

            }

          }
        );

      }
    );

  }


  /* =======================================================
     INITIALISIERUNG
  ======================================================= */

  function init() {

    createProfileModal();

    bindProfileLinks();


    /*
      Falls das Account-Menü dynamisch
      nachgeladen wird, erkennt der Observer
      auch später eingefügte "My Profile"-Links.
    */

    const observer =
      new MutationObserver(
        function() {

          bindProfileLinks();

        }
      );


    observer.observe(
      document.body,
      {
        childList: true,
        subtree: true
      }
    );

  }


  if (
    document.readyState ===
    "loading"
  ) {

    document.addEventListener(
      "DOMContentLoaded",
      init
    );

  } else {

    init();

  }

})();