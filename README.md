# Portfolio

Site pessoal CMS-driven para apresentar perfil, carreira, skills e projetos. O conteúdo vive no PostgreSQL e é editado no painel Avo; a home pública é uma página Inertia + Vue 3, com SSR, i18n (en / pt-BR) e identidade visual dark compartilhada entre o site e o admin.

Repositório: [leonardobdms/portfolio](https://github.com/leonardobdms/portfolio)

---

## Sumário

- [Visão geral](#visão-geral)
- [Stack](#stack)
- [Arquitetura](#arquitetura)
- [Modelo de domínio](#modelo-de-domínio)
- [Site público](#site-público)
- [Painel administrativo](#painel-administrativo)
- [Internacionalização](#internacionalização)
- [Design system](#design-system)
- [Pré-requisitos](#pré-requisitos)
- [Setup local](#setup-local)
- [Configuração](#configuração)
- [Testes e qualidade](#testes-e-qualidade)
- [CI](#ci)
- [Deploy](#deploy)
- [Estrutura do projeto](#estrutura-do-projeto)
- [Convenções](#convenções)

---

## Visão geral

O app é um portfólio de um único perfil (`Profile.current` = primeiro registro). Não há API REST pública nem SPA com roteador próprio: o Rails é a fonte da verdade. Controllers serializam os dados com Alba, o Typelizer gera os tipos TypeScript, e o Vue só renderiza.

Há dois superfícies:

| Superfície | Quem acessa | Tecnologia |
|---|---|---|
| Home `/` | Visitantes | Inertia + Vue 3, SSR |
| Admin `/admin` | Administradores autenticados | Avo 4, Devise |

Seções da home só aparecem quando há dados (skills, experiências, projetos em destaque, bio, formação, contato). A navegação do header é gerada a partir do mesmo critério.

---

## Stack

| Camada | Tecnologia | Versão |
|---|---|---|
| Linguagem | Ruby | 4.0.4 (`.ruby-version`) |
| Framework | Rails | ~> 8.1.3 |
| Banco | PostgreSQL | 16 (CI e accessory de produção) |
| Servidor | Puma + Thruster | — |
| Frontend | Vue 3 + TypeScript | Vue 3.5, TS ~6, Node 22.12.0 |
| Bridge | Inertia.js (`inertia_rails` + `@inertiajs/vue3`) | ~3.x |
| Serialização | Alba + alba-inertia | — |
| Tipos JS | Typelizer | rotas e serializers gerados |
| Assets | Vite (`rails_vite`) + Tailwind CSS 4 | — |
| UI | shadcn-vue (Reka UI), Lucide | New York |
| i18n | rails-i18n + vue-i18n | en, pt-BR |
| Auth admin | Devise | ~> 5.0 |
| CMS | Avo | >= 4.0 |
| Jobs / cache / cable | Solid Queue, Solid Cache, Solid Cable | — |
| Deploy | Kamal + Docker | imagem `portfolio` |
| Testes | RSpec, FactoryBot, Capybara, SimpleCov | cobertura 100% em models e serializers |

---

## Arquitetura

```
Browser
  │
  ├─ GET /                  HomeController#index
  │     └─ @profile (Alba → HomeIndexSerializer)
  │           └─ Vue page: app/frontend/pages/home/index.vue
  │
  ├─ GET /locale?locale=…   LocalesController#update  (cookie permanente)
  │
  ├─ GET /admins/sign_in    Admins::SessionsController (Inertia)
  │
  └─ /admin/*               Avo (authenticate :admin)
```

Fluxo de dados da home:

1. `HomeController` herda de `InertiaController` e define `@profile`.
2. `InertiaController` inclui `Alba::Inertia::Controller` e `use_inertia_instance_props`.
3. O serializer de página `HomeIndexSerializer` expõe `profile` via `ProfileSerializer`, que aninha experiências, formação, skills, projetos, certificações e redes sociais.
4. Typelizer gera `app/frontend/types/serializers/HomeIndex.ts` (e os demais).
5. A página Vue tipa as props com `HomeIndex` e deriva UI em `app/frontend/lib/home.ts` (projetos featured, agrupamento de skills, nav, datas, contato).

Locale é shared prop Inertia (`inertia_share locale`) e alimenta o `vue-i18n` no boot (`app/frontend/entrypoints/inertia.ts`).

SSR está ligado (`InertiaRails.configure { config.ssr_enabled = true }`). O Puma sobe o processo SSR via `plugin :inertia_ssr`. A imagem Docker pode desligar SSR com `--build-arg SSR_ENABLED=false`.

Não há Action Cable nem jobs de domínio no momento. Solid Queue roda dentro do Puma em produção (`SOLID_QUEUE_IN_PUMA=true`).

---

## Modelo de domínio

```
Profile 1 ──* Experience
        1 ──* Education
        1 ──* Certification
        1 ──* SocialLink
        1 ──* Skill
        1 ──* Project
                 * ──* Skill   (ProjectSkill)
Admin              (Devise, isolado do perfil)
```

### Profile

Registro âncora do site. Campos: nome, headline, bio, localização, e-mail, telefone, GitHub, LinkedIn, website, avatar, currículo, `available_for_work`.

`Profile.current` retorna o primeiro registro. O admin trata o perfil como recurso singular: index e new redirecionam para o registro existente.

### Experience

Cargo, empresa, tipo de contrato, localização, descrição, datas, `current`, `position`. Ordenação padrão: `position`, depois `id`.

### Education

Instituição, curso, grau, descrição, datas, `current`, `position`.

### Certification

Nome, emissor, descrição, URL/ID da credencial, datas de emissão/expiração, `position`.

### Skill

Nome, slug único, categoria, ícone (identificador kebab-case, não URL/SVG), nível, descrição, `position`. Ícone deve casar com `/\A[a-z0-9]+(?:-[a-z0-9]+)*\z/`.

Skills de especialidade na hero: slugs `ruby`, `ruby-on-rails`, `vue-js` (`SPECIALTY_SLUGS` em `app/frontend/lib/home.ts`).

### Project

Nome, slug único, descrições, imagem, GitHub, demo, `featured`, datas, `position`. A home só lista projetos com `featured: true`. Associação N:N com skills via `project_skills` (unicidade `project_id` + `skill_id`).

### SocialLink

Plataforma, URL, username, ícone, `position`. Se existirem, substituem o fallback GitHub/LinkedIn/website do próprio perfil.

### Admin

Devise: `database_authenticatable`, `recoverable`, `rememberable`, `validatable`. Sem cadastro público. Seeds criam um admin **somente em ambiente local**.

Coleções filhas do perfil ordenam por `position`. Destroy do perfil cascadeia para as associações.

---

## Site público

Página única (`pages/home/index.vue`), seções condicionais:

| Seção | Componente | Condição |
|---|---|---|
| Header sticky | `SiteHeader` | sempre |
| Hero | `HeroSection` | sempre (com dados do perfil) |
| Skills | `SkillsSection` | `skills.length > 0` |
| Experiência | `ExperienceSection` | `experiences.length > 0` |
| Projetos | `FeaturedProjectsSection` | algum `featured` |
| Sobre | `AboutSection` | `bio` presente |
| Formação | `EducationSection` | `educations.length > 0` |
| Contato | `ContactSection` | e-mail, telefone ou redes |

Helpers de apresentação ficam em `app/frontend/lib/home.ts` (não no template): featured, agrupamento por categoria, range de datas, `tel:` links, nav items.

Login do admin é Inertia (`pages/admins/sessions/new.vue`), não o view Devise padrão. Após login bem-sucedido usa `inertia_location` para `/admin`.

Health check: `GET /up` (silenciado nos logs de produção).

---

## Painel administrativo

- URL: `/admin` (Avo `root_path`)
- Gate: `authenticate :admin` nas rotas; visitantes vão para `/admins/sign_in`
- Home do Avo: show do primeiro perfil, ou index se ainda não existir
- Perfil é singular: `Avo::ProfilesController` redireciona index/new para o registro existente
- Sidebar customizada em três grupos: **Portfolio** (perfil, redes), **Carreira** (experiências, formação, certificações), **Trabalho** (projetos, skills)
- `ProjectSkill` existe como resource mas fica fora da sidebar (`visible_on_sidebar = false`)
- Locale do Avo segue o mesmo cookie/`Accept-Language` (`AvoLocale`)
- Aparência travada no dark brand (`scheme`, `neutral`, `accent` locked); tokens alinhados ao site (`avo-overrides.css` + `design_tokens.css`)

Credenciais de desenvolvimento (apenas `Rails.env.local?`, via `db/seeds.rb`):

```
e-mail:    admin@admin.com
senha:     password@123
```

---

## Internacionalização

Locales disponíveis: `en` (default) e `pt-BR`. Fallback ativo.

Resolução (`LocaleResolver`):

1. Cookie permanente `locale`, se for um locale suportado
2. Header `Accept-Language` (`pt*` → pt-BR, `en*` → en)
3. Default `en`

Troca: `GET /locale?locale=pt-BR` (ou `en`), persistida no cookie, redirect back no mesmo host.

Tradução em duas camadas:

| Camada | Arquivos | Uso |
|---|---|---|
| Rails | `config/locales/*.yml` | Avo, Active Record, Devise, título do app |
| Vue | `app/frontend/locales/{en,pt-BR}.json` | home, login, switcher |

O HTML raiz usa `lang="<%= I18n.locale %>"`. Datas na home usam `Intl.DateTimeFormat` com o locale atual.

---

## Design system

Hex **só** em `app/assets/stylesheets/design_tokens.css`. No Tailwind, usar as classes tokenizadas (`bg-background`, `text-text`, `border-border`, `bg-primary`, …). Não inventar cores nem hex isolado.

Identidade: dark, minimal, profissional, tecnológica. Sem visual gamer, neon, gradientes pesados ou sombras excessivas. Accent (`cyan`) só em destaques pequenos.

O Avo usa a mesma paleta (`config.appearance` + `avo-overrides.css`). Não criar tema de admin separado.

Componentes UI: `app/frontend/components/ui/` (shadcn-vue / Reka UI). Composição de páginas em `app/frontend/components/home/`.

---

## Pré-requisitos

- Ruby 4.0.4 (rbenv, asdf, ou equivalente)
- Node.js 22.12.0 (`.node-version`)
- PostgreSQL 16+
- Bundler e npm
- Opcional para `bin/dev`: Overmind, Hivemind ou Foreman

Variáveis locais padrão (podem ser sobrescritas):

| Variável | Default |
|---|---|
| `PORTFOLIO_DATABASE_USERNAME` | `postgres` |
| `PORTFOLIO_DATABASE_PASSWORD` | `postgres` |
| `PORTFOLIO_DATABASE_HOST` | `localhost` |
| `PORTFOLIO_DATABASE_PORT` | `5432` |
| `PORT` | `3000` |

---

## Setup local

```bash
git clone git@github.com:leonardobdms/portfolio.git
cd portfolio
bin/setup
```

`bin/setup` instala gems e pacotes npm, roda `db:prepare` e sobe o servidor (`bin/dev`). Para resetar o banco no setup:

```bash
bin/setup --reset
```

Para só preparar o ambiente, sem subir o server:

```bash
bin/setup --skip-server
```

Seeds populam o perfil, experiências, formação, skills, projetos, redes e o admin local.

### Desenvolvimento

```bash
bin/dev          # Rails + Vite (Procfile.dev)
```

- App: http://localhost:3000
- Admin: http://localhost:3000/admin
- Vite: processo `js` no Procfile

Console:

```bash
bin/rails console
```

Regenerar tipos TypeScript a partir dos serializers/rotas:

```bash
bin/rails typelizer:generate:refresh
```

Os arquivos em `app/frontend/types/serializers` e `app/frontend/routes` são gerados. Não editar à mão; o CI falha se estiverem desatualizados.

---

## Configuração

### Banco

`config/database.yml`:

- development: `portfolio_development`
- test: `portfolio_test`
- production: `portfolio_production` (+ databases Solid: cache, queue, cable)

Produção usa usuário `portfolio`, host `DB_HOST` (no Kamal: `portfolio-db`) e senha `PORTFOLIO_DATABASE_PASSWORD`.

### Segredos

- `RAILS_MASTER_KEY` — decrypt de `config/credentials.yml.enc`
- Kamal: `.kamal/secrets` injeta `RAILS_MASTER_KEY`, `PORTFOLIO_DATABASE_PASSWORD`, `POSTGRES_PASSWORD`

Não commitar `.env`, `master.key` nem secrets do Kamal.

### Inertia

`config/initializers/inertia_rails.rb`: versionamento por digest Vite, history encryption em produção, SSR ligado.

### Avo

`config/initializers/avo.rb`: `current_user_method :current_admin`, sign-out Devise, home no perfil.

---

## Testes e qualidade

```bash
bin/rspec                         # suíte
bin/rubocop                       # estilo Ruby
npm run lint                      # ESLint (zero warnings)
npm run format                    # Prettier --check
npm run check                     # vue-tsc + tsc
bin/brakeman --no-pager           # segurança estática
bin/bundler-audit                 # gems vulneráveis
bin/ci                            # pipeline local completa
```

SimpleCov cobre `app/models` e `app/serializers` com **mínimo 100%**.

Especificações:

| Área | Caminho |
|---|---|
| Models | `spec/models/` |
| Serializers | `spec/serializers/` |
| Login Devise/Inertia | `spec/requests/admins/sessions_spec.rb` |
| Avo (auth, identidade, perfil singular) | `spec/requests/avo_spec.rb` |
| Locale | `spec/requests/locales_spec.rb` |

Request specs de Inertia usam matchers (`render_component`, `have_props`, `have_flash`), não acesso direto a `inertia.component`.

O passo `bin/ci` também replanta seeds em test (`db:seed:replant`) e exige tipos Typelizer limpos no git.

---

## CI

GitHub Actions (`.github/workflows/ci.yml`) em PRs e pushes em `main`:

1. **scan_ruby** — Brakeman + bundler-audit
2. **lint_js** — ESLint, Prettier, typecheck
3. **lint** — RuboCop
4. **test** — Postgres 16, `db:test:prepare spec`; screenshots Capybara em falha

Dependabot semanal: bundler, npm e GitHub Actions.

---

## Deploy

Produção via **Kamal** (`config/deploy.yml`) em container Docker (`Dockerfile`).

| Item | Valor atual |
|---|---|
| Serviço | `portfolio` |
| Servidor web | `192.168.15.7` |
| SSH | user `leonardo` |
| Registry | local `localhost:5555` |
| DB accessory | Postgres 16 (`portfolio-db`), não exposto na LAN |
| Volume | `portfolio_storage:/rails/storage` |
| Assets | `/rails/public` (bridging entre deploys) |
| Jobs | Solid Queue no Puma |

SSL Let's Encrypt está comentado: o host atual é IP de LAN; a app sobe em HTTP. Para domínio público, descomentar `proxy.ssl` / `proxy.host` e ligar `assume_ssl` + `force_ssl` em produção.

Comandos úteis:

```bash
bin/kamal deploy
bin/kamal logs          # alias: app logs -f
bin/kamal console       # rails console no container
bin/kamal shell
bin/kamal dbc
```

Imagem: multi-stage, jemalloc, usuário não-root `rails`. Entry point (`bin/docker-entrypoint`) roda `db:prepare` ao iniciar o server. Assets precompilados no build; bundle SSR com `npx vite build --ssr` quando `SSR_ENABLED=true`.

---

## Estrutura do projeto

```
app/
  avo/resources/          Resources Avo (Profile, Project, Skill, …)
  controllers/
    home_controller.rb
    locales_controller.rb
    admins/sessions_controller.rb
    avo/                  Overrides (perfil singular)
    concerns/             SetLocale, AvoLocale
  frontend/
    entrypoints/          inertia.ts, application.css
    pages/                Páginas Inertia (home, login)
    components/home/      Seções da landing
    components/ui/        Primitivos shadcn-vue
    locales/              JSON vue-i18n
    lib/home.ts           Derivação de UI da home
    types/serializers/    Gerado pelo Typelizer
    routes/               Gerado pelo Typelizer
  models/
  serializers/            Alba (+ helpers Typelizer / alba-inertia)
  assets/stylesheets/     design_tokens.css, avo-overrides.css
config/
  deploy.yml              Kamal
  locales/                Rails i18n (en, pt-BR, Devise, Avo)
  initializers/           avo, inertia, typelizer, alba, devise
db/
  schema.rb
  seeds.rb
  migrate/
lib/locale_resolver.rb
spec/
Dockerfile
Procfile.dev
```

---

## Convenções

- **Inertia é server-driven.** Props vêm do controller. Não usar `useEffect` + `fetch` para dados de página. Forms: `useForm` / `<Form>` do Inertia, não react-hook-form (este app é Vue).
- **Redirects externos** (se surgirem): `inertia_location`, nunca `redirect_to` para URL fora da app em fluxo Inertia.
- **Serializers, não `as_json`.** Página `Home#index` → `HomeIndexSerializer`. Tipos TypeScript regenerados com Typelizer.
- **Cores:** tokens do design system. Avo e site compartilham a identidade.
- **i18n:** strings de UI no JSON Vue; labels de modelo/admin no YAML Rails. Não hardcodar copy visível.
- **Perfil único.** Novas entidades de conteúdo devem `belongs_to :profile` e ordenar por `position`.
- **Ícone de skill** é identificador (`ruby`, `vue-js`), nunca arquivo ou URL.
- **Não editar** `app/frontend/types/serializers` nem `app/frontend/routes` manualmente.

### Adicionar conteúdo na home

1. Campo/associação no model + migration + validação
2. Expor no serializer Alba correspondente
3. `bin/rails typelizer:generate:refresh`
4. Resource Avo (e sidebar, se for navegável)
5. Usar o campo na página/seção Vue
6. Specs de model e serializer (manter cobertura 100%)
