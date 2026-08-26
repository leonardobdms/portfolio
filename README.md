# Portfolio

CMS-driven personal site for profile, career, skills, and projects. Content lives in PostgreSQL and is edited in Avo. The public home is a single Inertia + Vue 3 page with SSR, i18n (en / pt-BR), and a dark visual identity shared by the site and the admin panel.

Repository: [leonardobdms/portfolio](https://github.com/leonardobdms/portfolio)

---

## Table of contents

- [Overview](#overview)
- [Stack](#stack)
- [Architecture](#architecture)
- [Domain model](#domain-model)
- [Public site](#public-site)
- [Admin panel](#admin-panel)
- [Internationalization](#internationalization)
- [Design system](#design-system)
- [Prerequisites](#prerequisites)
- [Local setup](#local-setup)
- [Configuration](#configuration)
- [Testing and quality](#testing-and-quality)
- [CI](#ci)
- [Deploy](#deploy)
- [Project structure](#project-structure)
- [Conventions](#conventions)

---

## Overview

The app is a single-profile portfolio (`Profile.current` is the first record). There is no public REST API and no client-side router: Rails is the source of truth. Controllers serialize data with Alba, Typelizer generates TypeScript types, and Vue only renders.

There are two surfaces:

| Surface | Audience | Stack |
|---|---|---|
| Home `/` | Visitors | Inertia + Vue 3, SSR |
| Admin `/admin` | Authenticated administrators | Avo 4, Devise |

Home sections render only when data exists (skills, experience, featured projects, bio, certifications, education, contact). Header navigation is derived from the same rules (education is on the page but not in the header nav).

---

## Stack

| Layer | Technology | Version |
|---|---|---|
| Language | Ruby | 4.0.4 (`.ruby-version`) |
| Framework | Rails | ~> 8.1.3 |
| Database | PostgreSQL | 16 (CI and production accessory) |
| Server | Puma + Thruster | — |
| Frontend | Vue 3 + TypeScript | Vue 3.5, TS ~6, Node 22.12.0 |
| Bridge | Inertia.js (`inertia_rails` + `@inertiajs/vue3`) | ~3.x |
| Serialization | Alba + alba-inertia | — |
| JS types | Typelizer | generated routes and serializers |
| Assets | Vite (`rails_vite`) + Tailwind CSS 4 | — |
| UI | shadcn-vue (Reka UI), Lucide | New York |
| i18n | rails-i18n + vue-i18n | en, pt-BR |
| Admin auth | Devise | ~> 5.0 |
| CMS | Avo | >= 4.0 |
| Jobs / cache / cable | Solid Queue, Solid Cache, Solid Cable | — |
| Deploy | Kamal + Docker | `portfolio` image |
| Tests | RSpec, FactoryBot, Capybara, SimpleCov, Vitest | 100% coverage on app Ruby (models, serializers, controllers, mailers, helpers, lib) and frontend lib |

---

## Architecture

```
Browser
  │
  ├─ GET /                     HomeController#index
  │     └─ @profile (Alba → HomeIndexSerializer)
  │           └─ Vue page: app/frontend/pages/home/index.vue
  │
  ├─ GET /projects/:slug       ProjectsController#show
  ├─ POST /contacts            ContactsController#create
  ├─ GET /locale?locale=…      LocalesController#update  (permanent cookie)
  ├─ GET /theme?theme=…        ThemesController#update   (permanent cookie)
  ├─ GET /sitemap.xml          SitemapsController#show
  ├─ GET /admins/sign_in       Admins::SessionsController (Inertia)
  │
  └─ /admin/*                  Avo (authenticate :admin)
```

Home data flow:

1. `HomeController` inherits from `InertiaController` and assigns `@profile`.
2. `InertiaController` includes `Alba::Inertia::Controller` and `use_inertia_instance_props`.
3. The page serializer `HomeIndexSerializer` exposes `profile` through `ProfileSerializer`, which nests experiences, education, skills, projects, certifications, and social links.
4. Typelizer generates `app/frontend/types/serializers/HomeIndex.ts` (and the rest).
5. The Vue page types props as `HomeIndex` and derives UI in `app/frontend/lib/home.ts` (featured projects, skill grouping, nav, dates, contact).

Locale is an Inertia shared prop (`inertia_share locale`) and feeds `vue-i18n` at boot (`app/frontend/entrypoints/inertia.ts`).

SSR is enabled (`InertiaRails.configure { config.ssr_enabled = true }`). Puma starts the SSR process via `plugin :inertia_ssr`. The Docker image can disable SSR with `--build-arg SSR_ENABLED=false`.

There are no Action Cable channels or domain jobs yet. Solid Queue runs inside Puma in production (`SOLID_QUEUE_IN_PUMA=true`).

---

## Domain model

```
Profile 1 ──* Experience
        1 ──* Education
        1 ──* Certification
        1 ──* SocialLink
        1 ──* Skill
        1 ──* Project
                 * ──* Skill   (ProjectSkill)
Admin              (Devise, isolated from the profile)
Contact            (inbound messages from the public form)
```

### Profile

Anchor record for the site. Fields: name, headline, bio, location, email, phone, GitHub, LinkedIn, website, avatar, resume, `available_for_work`.

`Profile.current` returns the first record. Admin treats the profile as a singular resource: index and new redirect to the existing record.

### Experience

Role, company, employment type, location, description, dates, `current`, `position`. Default order: `position`, then `id`.

### Education

Institution, course, degree, description, dates, `current`, `position`.

### Certification

Name, issuer, description, credential URL/ID, issued/expires dates, `position`.

### Skill

Name, unique slug, category, icon (kebab-case identifier, not a URL or SVG), level, description, `position`. Icon must match `/\A[a-z0-9]+(?:-[a-z0-9]+)*\z/`.

Hero specialty skills: slugs `ruby`, `ruby-on-rails`, `vue-js` (`SPECIALTY_SLUGS` in `app/frontend/lib/home.ts`).

### Project

Name, unique slug, descriptions, image, GitHub, demo, `featured`, dates, `position`. The home page lists only projects with `featured: true`. Many-to-many with skills via `project_skills` (unique `project_id` + `skill_id`).

### SocialLink

Platform, URL, username, icon, `position`. When present, they replace the profile's GitHub/LinkedIn/website fallback.

### Contact

Public form submissions: name, email, subject, message, plus `ip` and `user_agent`. Hidden from the Avo sidebar; opened from the profile or by URL.

### Admin

Devise modules: `database_authenticatable`, `recoverable`, `rememberable`, `validatable`. No public sign-up. Seeds create an admin **only in the local environment**.

Profile child collections order by `position`. Destroying a profile cascades to associations.

---

## Public site

Single page (`pages/home/index.vue`) with conditional sections:

| Section | Component | Condition |
|---|---|---|
| Sticky header | `SiteHeader` | always |
| Hero | `HeroSection` | always (from profile data) |
| Skills | `SkillsSection` | `skills.length > 0` |
| Experience | `ExperienceSection` | `experiences.length > 0` |
| Projects | `FeaturedProjectsSection` | any `featured` |
| About | `AboutSection` | `bio` present |
| Certifications | `CertificationsSection` | `certifications.length > 0` |
| Education | `EducationSection` | `educations.length > 0` |
| Contact | `ContactSection` | email, phone, or socials |
| Footer | `SiteFooter` | always |

Project detail is a second public page (`pages/projects/show.vue`) at `/projects/:slug`.

The contact form posts to `POST /contacts`. It uses a honeypot field, Cloudflare Turnstile (`TURNSTILE_SITE_KEY` / `TURNSTILE_SECRET_KEY`), and an IP rate limit (5 messages / hour). Valid messages are stored and emailed with `ContactMailer`.

Presentation helpers live in `app/frontend/lib/home.ts` (not in the template): featured projects, grouping by category, date ranges, WhatsApp links, nav items.

Admin login is Inertia (`pages/admins/sessions/new.vue`), not the default Devise view. A successful sign-in uses `inertia_location` to `/admin`.

Health check: `GET /up` (silenced in production logs). Theme is a permanent `theme` cookie (`dark` default, `light` supported), shared with Inertia as `theme`.

---

## Admin panel

- URL: `/admin` (Avo `root_path`)
- Gate: `authenticate :admin` on routes; guests go to `/admins/sign_in`
- Avo home: show the first profile, or the index if none exists
- Profile is singular: `Avo::ProfilesController` redirects index/new to the existing record
- Custom sidebar in three groups: **Portfolio** (profile, socials), **Career** (experiences, education, certifications), **Work** (projects, skills)
- `ProjectSkill` exists as a resource but is hidden from the sidebar (`visible_on_sidebar = false`)
- Avo locale follows the same cookie / `Accept-Language` (`AvoLocale`)
- Appearance is locked to the dark brand (`scheme`, `neutral`, `accent` locked); tokens match the site (`avo-overrides.css` + `design_tokens.css`)

Development credentials (only when `Rails.env.local?`, via `db/seeds.rb`):

```
email:     admin@admin.com
password:  password@123
```

---

## Internationalization

Available locales: `en` (default) and `pt-BR`. Fallbacks are enabled.

Resolution (`LocaleResolver`):

1. Permanent `locale` cookie, if it is a supported locale
2. `Accept-Language` header (`pt*` → pt-BR, `en*` → en)
3. Default `en`

Switch: `GET /locale?locale=pt-BR` (or `en`), stored in the cookie, redirect back on the same host.

Translation layers:

| Layer | Files | Usage |
|---|---|---|
| Rails | `config/locales/*.yml` | Avo, Active Record, Devise, app title |
| Vue | `app/frontend/locales/{en,pt-BR}.json` | home, login, switcher |

The root HTML uses `lang="<%= I18n.locale %>"`. Dates on the home page use `Intl.DateTimeFormat` with the current locale.

---

## Design system

Hex values live **only** in `app/assets/stylesheets/design_tokens.css`. In Tailwind, use tokenized classes (`bg-background`, `text-text`, `border-border`, `bg-primary`, …). Do not invent colors or isolated hex values.

Identity: dark, minimal, professional, technological. No gamer look, neon, heavy gradients, or excess shadows. Accent (`cyan`) is for small highlights only.

Avo uses the same palette (`config.appearance` + `avo-overrides.css`). Do not create a separate admin theme.

UI primitives: `app/frontend/components/ui/` (shadcn-vue / Reka UI). Page composition: `app/frontend/components/home/`.

---

## Prerequisites

- Ruby 4.0.4 (rbenv, asdf, or equivalent)
- Node.js 22.12.0 (`.node-version`)
- PostgreSQL 16+
- Bundler and npm
- Optional for `bin/dev`: Overmind, Hivemind, or Foreman

Local defaults (overridable):

| Variable | Default |
|---|---|
| `PORTFOLIO_DATABASE_USERNAME` | `postgres` |
| `PORTFOLIO_DATABASE_PASSWORD` | `postgres` |
| `PORTFOLIO_DATABASE_HOST` | `localhost` |
| `PORTFOLIO_DATABASE_PORT` | `5432` |
| `PORT` | `3000` |

---

## Local setup

```bash
git clone git@github.com:leonardobdms/portfolio.git
cd portfolio
bin/setup
```

`bin/setup` installs gems and npm packages, runs `db:prepare`, and starts the server (`bin/dev`). To reset the database during setup:

```bash
bin/setup --reset
```

To prepare the environment without starting the server:

```bash
bin/setup --skip-server
```

Seeds populate the profile, experiences, education, skills, projects, social links, and the local admin.

### Development

```bash
bin/dev          # Rails + Vite (Procfile.dev)
```

- App: http://localhost:3000
- Admin: http://localhost:3000/admin
- Vite: `js` process in the Procfile

Console:

```bash
bin/rails console
```

Regenerate TypeScript types from serializers and routes:

```bash
bin/rails typelizer:generate:refresh
```

Files under `app/frontend/types/serializers` and `app/frontend/routes` are generated. Do not edit them by hand; CI fails if they are stale.

---

## Configuration

### Database

`config/database.yml`:

- development: `portfolio_development`
- test: `portfolio_test`
- production: `portfolio_production` (plus Solid databases: cache, queue, cable)

Production uses user `portfolio` (`PORTFOLIO_DATABASE_USERNAME`), host `PORTFOLIO_DATABASE_HOST` (Kamal: `portfolio-db`), and password `PORTFOLIO_DATABASE_PASSWORD`.

### Secrets

- `RAILS_MASTER_KEY` — decrypts `config/credentials.yml.enc`
- Kamal: `.kamal/secrets` injects `RAILS_MASTER_KEY`, `PORTFOLIO_DATABASE_PASSWORD`, `POSTGRES_PASSWORD`

Do not commit `.env`, `master.key`, or Kamal secrets.

### Inertia

`config/initializers/inertia_rails.rb`: versioning from the Vite digest, history encryption in production, SSR enabled.

### Contact / Turnstile

| Variable | Purpose |
|---|---|
| `TURNSTILE_SITE_KEY` | Public widget key (Inertia shared prop) |
| `TURNSTILE_SECRET_KEY` | Server-side verification. Blank in local env skips the remote check |
| `ANALYTICS_SCRIPT_URL` / `ANALYTICS_WEBSITE_ID` | Optional production analytics snippet |

### Avo

`config/initializers/avo.rb`: `current_user_method :current_admin`, Devise sign-out, home on the profile.

---

## Testing and quality

Keep **100% coverage** and RuboCop-clean Ruby. Specs must cover every public home section (including the empty/hidden case). Update the README in the same change as behavior.

```bash
bin/rspec                         # suite (SimpleCov 100%)
bin/rubocop                       # Ruby style
npm run test                      # Vitest (100% on frontend lib)
npm run lint                      # ESLint (zero warnings)
npm run format                    # Prettier --check
npm run check                     # vue-tsc + tsc
bin/brakeman --no-pager           # static security
bin/bundler-audit                 # vulnerable gems
bin/ci                            # full local pipeline
```

SimpleCov covers `app/models`, `app/serializers`, `app/controllers`, `app/mailers`, `app/helpers`, and `lib/` with a **100% minimum**. Vitest covers `app/frontend/lib` and `app/frontend/i18n.ts` at **100%**.

Specs:

| Area | Path |
|---|---|
| Models | `spec/models/` |
| Serializers | `spec/serializers/` |
| Lib | `spec/lib/` |
| Helpers | `spec/helpers/` |
| Mailers | `spec/mailers/` |
| Home (all sections) | `spec/requests/home_spec.rb`, `spec/system/home_a11y_spec.rb` |
| Projects | `spec/requests/projects_spec.rb` |
| Contact form | `spec/requests/contacts_spec.rb` |
| Devise/Inertia login | `spec/requests/admins/sessions_spec.rb` |
| Avo (auth, identity, resources) | `spec/requests/avo_spec.rb` |
| Locale / theme | `spec/requests/locales_spec.rb`, `spec/requests/themes_spec.rb` |
| Sitemap | `spec/requests/sitemaps_spec.rb` |
| Frontend lib | `app/frontend/**/*.test.ts` |

Inertia request specs use matchers (`render_component`, `have_props`, `have_flash`), not direct access to `inertia.component`. After POST/PATCH/DELETE with redirect, call `follow_redirect!` before asserting flash or props.

`bin/ci` also replants seeds in test (`db:seed:replant`) and requires Typelizer types to be clean in git.

---

## CI

GitHub Actions (`.github/workflows/ci.yml`) on PRs and pushes to `main`:

1. **scan_ruby** — Brakeman + bundler-audit
2. **lint_js** — ESLint, Prettier, typecheck
3. **test_js** — Vitest
4. **lint** — RuboCop
5. **test** — Postgres 16, `db:test:prepare spec`; Capybara screenshots on failure

Weekly Dependabot: bundler, npm, and GitHub Actions.

---

## Deploy

Production uses **Kamal** (`config/deploy.yml`) and a Docker container (`Dockerfile`).

| Item | Current value |
|---|---|
| Service | `portfolio` |
| Web server | `192.168.15.7` |
| SSH | user `leonardo` |
| Registry | local `localhost:5555` |
| DB accessory | Postgres 16 (`portfolio-db`), not exposed on the LAN |
| Volume | `portfolio_storage:/rails/storage` |
| Assets | `/rails/public` (bridged across deploys) |
| Jobs | Solid Queue in Puma |

Public HTTPS is Cloudflare Tunnel → `http://localhost:80` (kamal-proxy). `proxy.ssl` stays off so Let's Encrypt does not fight Cloudflare. Rails has `assume_ssl` + `force_ssl`. The tunnel hostname `leonardombd.dev.br` must be a dedicated ingress rule *before* other apps (Glitchtip on `:8000`).

Useful commands:

```bash
bin/kamal deploy
bin/kamal logs          # alias: app logs -f
bin/kamal console       # rails console in the container
bin/kamal shell
bin/kamal dbc
```

Image: multi-stage, jemalloc, non-root `rails` user. The entrypoint (`bin/docker-entrypoint`) runs `db:prepare` when starting the server. Assets are precompiled at build time; the SSR bundle is built with `npx vite build --ssr` when `SSR_ENABLED=true`.

---

## Project structure

```
app/
  avo/resources/          Avo resources (Profile, Project, Skill, …)
  controllers/
    home_controller.rb
    locales_controller.rb
    themes_controller.rb
    contacts_controller.rb
    projects_controller.rb
    sitemaps_controller.rb
    admins/sessions_controller.rb
    avo/                  overrides (singular profile)
    concerns/             SetLocale, SetTheme, AvoLocale
  frontend/
    entrypoints/          inertia.ts, application.css
    pages/                Inertia pages (home, project, login)
    components/home/      landing sections
    components/ui/        shadcn-vue primitives
    locales/              vue-i18n JSON
    lib/                  home UI derivation, icons, theme
    types/serializers/    generated by Typelizer
    routes/               generated by Typelizer
  models/
  serializers/            Alba (+ Typelizer / alba-inertia helpers)
  mailers/                ContactMailer
  assets/stylesheets/     design_tokens.css, avo-overrides.css
config/
  deploy.yml              Kamal
  locales/                Rails i18n (en, pt-BR, Devise, Avo)
  initializers/           avo, inertia, typelizer, alba, devise
db/
  schema.rb
  seeds.rb
  migrate/
lib/                      LocaleResolver, ThemeResolver, TurnstileVerifier, ContactRateLimit
spec/
Dockerfile
Procfile.dev
```

---

## Conventions

- **Inertia is server-driven.** Props come from the controller. Do not use `useEffect` + `fetch` for page data. Forms: Inertia `useForm` / `<Form>`, not react-hook-form (this app is Vue).
- **External redirects** (if they appear): `inertia_location`, never `redirect_to` for a URL outside the app in an Inertia flow.
- **Serializers, not `as_json`.** Page `Home#index` → `HomeIndexSerializer`. TypeScript types are regenerated with Typelizer.
- **Colors:** design-system tokens. Avo and the site share the same identity.
- **i18n:** UI strings in Vue JSON; model/admin labels in Rails YAML. Do not hardcode visible copy.
- **Single profile.** New content entities should `belongs_to :profile` and order by `position`.
- **Skill icons** are identifiers (`ruby`, `vue-js`), never files or URLs.
- **Do not edit** `app/frontend/types/serializers` or `app/frontend/routes` by hand.
- **100% coverage.** Ruby SimpleCov and Vitest lib coverage stay at 100%. New behavior ships with tests.
- **RuboCop.** Ruby changes must stay organized (`bin/rubocop`).
- **Docs.** Update `README.md` in the same change as behavior, routes, env vars, or quality-bar changes.

### Adding content to the home page

1. Field/association on the model + migration + validation
2. Expose it on the matching Alba serializer
3. `bin/rails typelizer:generate:refresh`
4. Avo resource (and sidebar, if it should be navigable)
5. Use the field in the Vue page/section
6. Specs for the model, serializer, and home section (keep 100% coverage; cover the empty/hidden case)
