# Happy Media — Redizajn sajta (2026)

Moderan redizajn sajta **happymedia.rs** u Claude-inspired estetici. Isporuka uključuje HTML/CSS kod spreman za postavljanje, kompletan schema markup i SEO optimizaciju, plus 4 Canva mockup kandidata za vizuelnu prezentaciju pre kodiranja.

---

## Canva mockup — izaberi dizajn

Canva je generisao 4 kandidata. Otvori linkove i reci mi koji ti se najviše dopada — mogu ga odmah ubaciti u tvoj Canva nalog (`create-design-from-candidate`) i eksportovati u PDF.

1. [Kandidat 1 (cwvFBe0Qgfadwwe)](https://www.canva.com/d/cwvFBe0Qgfadwwe)
2. [Kandidat 2 (QMwxJzpzkCsodmy)](https://www.canva.com/d/QMwxJzpzkCsodmy)
3. [Kandidat 3 (srgEhOocWZpyQF1)](https://www.canva.com/d/srgEhOocWZpyQF1)
4. [Kandidat 4 (aMrcSYE4crzPZ9K)](https://www.canva.com/d/aMrcSYE4crzPZ9K)

---

## Struktura fajlova

| Fajl | Svrha |
|---|---|
| `index.html` | Home (title: "Agencija za digitalni online marketing Happy Media Beograd Srbija") |
| `izrada-sajtova.html` | Izrada sajtova WordPress od 380 € |
| `optimizacija-sajta.html` | SEO optimizacija sajta |
| `online-marketing.html` | Google Ads, Facebook, Instagram kampanje |
| `odrzavanje-sajta.html` | Održavanje sajta od 30 €/mesec |
| `priprema-za-stampu.html` | Grafička priprema za štampu |
| `kontakt.html` | Kontakt + Calendly embed |
| `styles.css` | Jedinstveni CSS za sve stranice |
| `sitemap.xml` | Sitemap za Google Search Console |
| `robots.txt` | Pravila za crawlere + sitemap referenca |

---

## Dizajn

- **Paleta** (Claude-inspired): cream `#FAF9F5`, warm black `#141413`, terracotta `#D97757`
- **Tipografija**: Poppins (naslovi) + Lora (body) — preko Google Fonts, preconnect
- **Layout**: minimalistički, editorial, generozan whitespace
- **Responsive**: mobile-first, breakpoint 860px
- **Dark mode**: nije uključen u ovoj verziji (može se dodati naknadno)
- **Animacije**: suptilne, poštuju `prefers-reduced-motion`

---

## SEO i schema markup

### Meta tagovi (svaka stranica)
- `<title>` jedinstven po stranici, usklađen sa ciljnim ključnim rečima
- `meta description` (150–160 karaktera)
- `meta keywords` (za Yandex / lokalne crawlere)
- `canonical` URL
- Open Graph (Facebook, LinkedIn share preview)
- Twitter Card
- `theme-color`, favicon, apple-touch-icon
- `<html lang="sr-Latn-RS">` — pravilna lokalizacija

### JSON-LD schema (strukturirani podaci)
| Schema tip | Gde |
|---|---|
| `Organization` | index.html |
| `ProfessionalService` + `LocalBusiness` (adresa, radno vreme, geo, aggregateRating) | index.html |
| `WebSite` | index.html |
| `Service` (posebno za svaku uslugu) | izrada-sajtova, optimizacija-sajta, online-marketing, odrzavanje-sajta, priprema-za-stampu |
| `BreadcrumbList` | sve podstranice |
| `FAQPage` | izrada-sajtova.html |
| `ContactPage` | kontakt.html |
| `Offer` sa cenom i valutom | izrada-sajtova (380 EUR), odrzavanje-sajta (30 EUR/mesec) |

### Ključne reči targetovane (iz title-a)
- "agencija za digitalni online marketing" (home)
- "izrada sajtova WordPress", "izrada sajta", "web dizajn" (izrada-sajtova)
- "optimizacija sajta", "SEO", "Google rangiranje" (optimizacija-sajta)
- "online marketing", "Google Ads", "Facebook Ads", "oglašavanje na internetu" (online-marketing)
- "održavanje sajta", "administracija sajta" (odrzavanje-sajta)
- "priprema za štampu", "grafička priprema" (priprema-za-stampu)

### Provera schema markup-a
Pre deploy-a, proveri:
1. https://validator.schema.org/ — ubaci URL ili paste-uj JSON-LD blok
2. https://search.google.com/test/rich-results — Google rich results test

---

## Calendly integracija

Calendly je embed-ovan na `kontakt.html` kao inline widget.

**VAŽNO**: u fajlu `kontakt.html` je placeholder URL `https://calendly.com/happymedia-rs/30min`. Zameni ga svojim stvarnim Calendly linkom (traži `data-url=` u `kontakt.html`).

Primary color embed-a je već podešen na `#D97757` da se uklopi u brand.

---

## Accessibility

- Semantički HTML (`<header>`, `<nav>`, `<main>`, `<section>`, `<article>`, `<footer>`)
- Skip link na vrhu svake stranice
- ARIA atributi na nav toggle dugmetu
- `:focus-visible` stilovi sa vidljivim fokus indikatorom
- `prefers-reduced-motion` media query poštuje sistemski setting
- Kontrast tekst/pozadina iznad WCAG AA praga (proveri sa https://webaim.org/resources/contrastchecker/)

---

## Deploy na Vercel

Fajlovi su spremni — `vercel.json` je konfigurisan sa:
- `cleanUrls: true` → `/izrada-sajtova` umesto `/izrada-sajtova.html`
- Security headers (X-Content-Type-Options, X-Frame-Options, Referrer-Policy, Permissions-Policy)
- Cache kontrola za CSS i HTML
- 301 redirect sa trailing slash varijanti (da ne bude duplog URL-a)

### Opcija 1: Drag & drop (najlakše, bez CLI-ja)

1. Idi na **https://vercel.com/new**
2. Ulogin preko GitHub/GitLab/Bitbucket naloga (ili email-a)
3. Klikni **"Drop to deploy"** i prevuci ceo `outputs` folder
4. Vercel automatski detektuje static site i deploy-uje — za ~30 sekundi dobijaš `happymedia.vercel.app` URL

### Opcija 2: Vercel CLI (iz outputs foldera)

```bash
cd /path/to/outputs
npx vercel login       # prvo puta — email verifikacija
npx vercel              # preview deploy
npx vercel --prod       # production deploy
```

### Opcija 3: GitHub + auto-deploy

1. `git init` u outputs folderu, push na GitHub repo
2. Vercel.com → **Add New Project** → import repo
3. Svaki push automatski deploy-uje

### Povezivanje `happymedia.rs` domena

Nakon prvog deploy-a:
1. Vercel dashboard → tvoj projekat → **Settings → Domains**
2. Dodaj `happymedia.rs` i `www.happymedia.rs`
3. Vercel će ti dati DNS records (A record na `76.76.21.21` ili CNAME na `cname.vercel-dns.com`)
4. Kod registrara domena (gde god je happymedia.rs registrovan) zameni postojeće A/CNAME records
5. SSL sertifikat se automatski generiše u roku od nekoliko minuta

---

## Šta treba uraditi pre production deploy-a

1. **Calendly URL** — zam