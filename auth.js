const SUPABASE_URL = "https://orbrkdrsihsacsnprewf.supabase.co";
const SUPABASE_PUBLISHABLE_KEY =
  "sb_publishable_wc3w2fSuj8ItwiF6XBoQgw_HeW5_rNW";

const { createClient } = window.supabase;

const supabaseClient = createClient(
  SUPABASE_URL,
  SUPABASE_PUBLISHABLE_KEY
);

const DUPLICATE_EMAIL_MESSAGE =
  "Du hast dich mit dieser E-Mail schon angemeldet. Bitte melde dich stattdessen an.";


/* =========================================================
   REGISTRIERUNG
   ========================================================= */

async function registerUser({ email, password, name }) {
  const cleanEmail = email.trim().toLowerCase();
  const cleanName = name.trim();

  const { data, error } = await supabaseClient.auth.signUp({
    email: cleanEmail,
    password: password,
    options: {
      data: {
        display_name: cleanName
      },
      emailRedirectTo: window.location.origin + window.location.pathname
    }
  });

  /* Bereits registrierte E-Mail über Supabase-Fehler */
  if (error) {
    const message = String(error.message || "").toLowerCase();

    if (
      message.includes("already registered") ||
      message.includes("already exists") ||
      message.includes("email already") ||
      message.includes("user already") ||
      message.includes("email_exists") ||
      message.includes("user_already_exists")
    ) {
      return {
        data: null,
        error: new Error(DUPLICATE_EMAIL_MESSAGE),
        duplicateEmail: true
      };
    }

    return {
      data: null,
      error: error,
      duplicateEmail: false
    };
  }

  /*
    Supabase kann bei einer bereits existierenden E-Mail
    absichtlich keinen normalen Fehler zurückgeben.

    In diesem Fall ist identities leer.
  */
  if (
    data &&
    data.user &&
    Array.isArray(data.user.identities) &&
    data.user.identities.length === 0
  ) {
    return {
      data: data,
      error: new Error(DUPLICATE_EMAIL_MESSAGE),
      duplicateEmail: true
    };
  }

  return {
    data: data,
    error: null,
    duplicateEmail: false
  };
}


/* =========================================================
   LOGIN
   ========================================================= */

async function loginUser(email, password) {
  return await supabaseClient.auth.signInWithPassword({
    email: email.trim().toLowerCase(),
    password: password
  });
}


/* =========================================================
   LOGOUT
   ========================================================= */

async function logoutUser() {
  return await supabaseClient.auth.signOut();
}


/* =========================================================
   EXPORT
   ========================================================= */

window.MilesApartAuth = {
  supabaseClient,
  registerUser,
  loginUser,
  logoutUser,
  DUPLICATE_EMAIL_MESSAGE
};