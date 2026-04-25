/* ─── Happy Media — Calendly integracija (A+B) ─────────────────────────────
   A) Popup widget na klik svakog CTA dugmeta koje vodi ka kontakt strani
   B) Floating badge widget u donjem desnom uglu (skip na kontakt stranici)
   Calendly link: https://calendly.com/marko-happymedia/30min                   */

(function() {
  var CALENDLY_URL = 'https://calendly.com/marko-happymedia/30min?hide_gdpr_banner=1&primary_color=d97757&background_color=ffffff';

  // Detect if we're already on a contact/scheduling page (skip badge there to avoid duplicate UI)
  var path = window.location.pathname.toLowerCase();
  var isContactPage = /kontakt|contact|lianxi/.test(path);

  // ─── 1. Load Calendly assets (CSS + JS) ────────────────────────────────────
  var css = document.createElement('link');
  css.rel = 'stylesheet';
  css.href = 'https://assets.calendly.com/assets/external/widget.css';
  document.head.appendChild(css);

  var script = document.createElement('script');
  script.src = 'https://assets.calendly.com/assets/external/widget.js';
  script.async = true;

  script.onload = function() {
    if (!window.Calendly) return;

    // ─── 2. Badge widget (B) — floating button in corner ────────────────────
    // Skip on contact pages where inline widget already exists.
    if (!isContactPage) {
      // Multilingual badge text based on <html lang>
      var lang = (document.documentElement.lang || 'sr').toLowerCase();
      var badgeText = {
        'sr-latn-rs': 'Zakaži razgovor',
        'sr':         'Zakaži razgovor',
        'en':         'Book a call',
        'de':         'Gespräch buchen',
        'ru':         'Записаться',
        'zh-hans':    '预约咨询',
        'zh':         '预约咨询'
      }[lang] || 'Zakaži razgovor';

      Calendly.initBadgeWidget({
        url:       CALENDLY_URL,
        text:      badgeText,
        color:     '#2D5A3D',     // brand green
        textColor: '#ffffff',
        branding:  false
      });
    }
  };
  document.head.appendChild(script);

  // ─── 3. Popup on CTA click (A) — intercept link clicks ─────────────────────
  // Convert clicks on key CTA buttons → open Calendly modal instead of nav.
  // Targets: any link with class .nav-cta, .btn-dark, .btn-primary that points
  // to a contact page. Skip if we're already ON the contact page.
  function isContactLink(href) {
    if (!href) return false;
    return /(?:kontakt|contact|lianxi)\.html$|\/(kontakt|contact|lianxi)\/?$/.test(href);
  }

  function attachPopupHandlers() {
    if (isContactPage) return; // don't override on contact page itself
    var ctaLinks = document.querySelectorAll('a.nav-cta, a.btn-dark, a.btn-primary, a.btn');
    ctaLinks.forEach(function(link) {
      var href = link.getAttribute('href');
      if (!isContactLink(href)) return;

      link.addEventListener('click', function(e) {
        if (window.Calendly && window.Calendly.initPopupWidget) {
          e.preventDefault();
          window.Calendly.initPopupWidget({ url: CALENDLY_URL });
          return false;
        }
        // Fallback: let the browser navigate to the contact page if Calendly didn't load
      });
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', attachPopupHandlers);
  } else {
    attachPopupHandlers();
  }
})();
