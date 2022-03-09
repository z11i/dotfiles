// ************ theme ************ //
user_pref('devtools.theme', 'dark');
user_pref('toolkit.legacyUserProfileCustomizations.stylesheets', true);
// css blur filter - 88 above
user_pref("layout.css.backdrop-filter.enabled", true);
// fill SVG color
user_pref("svg.context-properties.content.enabled", true);

// ************ browsing ************ //
user_pref('findbar.highlightAll', true);

// ************ urlbar ************ //
user_pref("browser.urlbar.suggest.calculator", true);
user_pref("browser.urlbar.unitConversion.enabled", true);

// ************ search bar ************ //
user_pref("browser.search.openintab", true);

// ************ performance ************ //
user_pref("gfx.webrender.all", true);

// ************ to override arkenfox defaults ************ //
user_pref("webgl.disabled", false); // 4520 = webgl
user_pref("devtools.chrome.enabled", true); // 2607
user_pref("keyword.enabled", false); // 0001
