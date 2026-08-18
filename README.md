# Portfolio — Leonardo Martins Bueno Dias

Public site built with Rails and Vue, with content managed through an admin panel.

The frontend consumes a payload assembled on the backend (`Site::Payload`). Profile, skills, contacts, experiences, and projects are edited in Avo, so publishing content does not require code changes.

## Stack

| Layer | Technology |
| --- | --- |
| Backend | Ruby on Rails 8.1, Inertia Rails, Avo, Devise |
| Frontend | Vue 3, TypeScript, Vite, Tailwind CSS 4, GSAP |
| Database | PostgreSQL 16 |
| i18n | `pt-BR` (default) and `en` |

## Requirements

- Ruby `4.0.4` (see `.ruby-version`)
- Node.js and npm
- Bundler
- Docker, or a local PostgreSQL 16 instance

## Local setup

```bash
cp .env.example .env
docker compose up -d
bundle install
npm install
bin/rails db:prepare
bin/rails db:seed
bin/dev
```

`docker compose` starts PostgreSQL with user and password `postgres`, matching `.env.example`. If you already have a database on the host, update `POSTGRES_*` in `.env`.

### URLs

| Resource | URL |
| --- | --- |
| Site | http://localhost:3000 |
| Admin | http://localhost:3000/admin |
| Sign in | http://localhost:3000/admins/sign_in |

In local environments, the seed creates an admin from `ADMIN_EMAIL` and `ADMIN_PASSWORD`. Defaults are `admin@localhost` and `changeme`. Change them in `.env` before seeding.

## Environment variables

| Variable | Purpose |
| --- | --- |
| `POSTGRES_HOST` | PostgreSQL host |
| `POSTGRES_USER` | PostgreSQL user |
| `POSTGRES_PASSWORD` | PostgreSQL password |
| `ADMIN_EMAIL` | Admin email created by the seed |
| `ADMIN_PASSWORD` | Admin password created by the seed |
| `INERTIA_DEFAULT_RENDER` | Maps `HomeController#index` to `app/frontend/pages/home/index.vue` |

The seed creates the admin automatically only in `development` and `test`. In other environments, `ADMIN_EMAIL` and `ADMIN_PASSWORD` must be set.

## Content management

The panel at `/admin` controls what appears on the site.

| Resource | Effect on the site |
| --- | --- |
| Profile | Name, copy, hero highlights, SEO. There is a single record. |
| Skills | Technologies in the skills section and icons used in experiences and projects |
| Contacts | GitHub, LinkedIn, email, and other links. They appear only when published and with a URL. |
| Experiences | Professional timeline |
| Projects | Cards, technologies, highlights, and URLs |
| Admins | Accounts with access to the panel |

### Skill levels

| Level | Where it appears |
| --- | --- |
| Featured (`featured`) | Skills section, highlighted |
| Core (`core`) | Complementary strip in the skills section |
| Catalog (`catalog`) | Not listed in the section; used only as an icon in lists (experiences, projects, highlights) |

Display order follows `position` (lower numbers first). Icons use the [Simple Icons](https://simpleicons.org) slug, for example `rubyonrails`, `vuedotjs`, or `postgresql`.

## Relevant structure

```
app/
  controllers/          # Home and authentication
  models/               # Profile, Skill, Contact, Experience, Project, Admin
  services/site/        # Payload sent to Inertia
  avo/resources/        # Admin panel resources
  frontend/
    pages/home/         # Public page
    components/         # Sections and UI
    locales/            # Vue translations
config/locales/         # Rails, Devise, and Avo translations
db/seeds/               # Initial skills and projects
```

## Commands

```bash
bin/dev                 # Rails + Vite
bin/rails test          # Tests
bin/rubocop             # Ruby lint
npm run build           # Frontend build
```
