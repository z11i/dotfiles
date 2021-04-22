/**
 * First of all, `devtools.chrome.enabled` must be set to `true` for browser console to work.
 * See https://superuser.com/a/1609893/1042635 for more details.
 */
Services.prefs.setBoolPref('browser.search.suggest.enabled', false);
Services.prefs.setBoolPref('browser.ctrlTab.sortByRecentlyUsed', true);
Services.prefs.setStringPref('devtools.theme', 'dark');
Services.prefs.setBoolPref('extensions.pocket.enabled', false);
Services.prefs.setBoolPref('findbar.highlightAll', true);
Services.prefs.setBoolPref('toolkit.legacyUserProfileCustomizations.stylesheets', true);