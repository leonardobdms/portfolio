import { createInertiaApp } from "@inertiajs/vue3"
import * as Sentry from "@sentry/vue"
import type { DefineComponent } from "vue"

import { initFlashNotifications } from "@/composables/useFlash"
import { createI18nInstance, localeFromPage } from "@/i18n"
import AppLayout from "@/layouts/AppLayout.vue"

initFlashNotifications()

const pages = import.meta.glob<{
  default: DefineComponent & { layout?: unknown }
}>("../pages/**/*.vue", { eager: true })

createInertiaApp({
  resolve: (name) => {
    const page = pages[`../pages/${name}.vue`]
    if (!page) {
      throw new Error(`Page not found: ${name}`)
    }

    if (!page.default.layout) {
      page.default.layout = AppLayout
    }

    return page
  },
  defaults: {
    form: {
      forceIndicesArrayFormatInFormData: false,
    },
    visitOptions: () => ({
      queryStringArrayFormat: "brackets",
    }),
  },
  withApp(app, { page }) {
    if (import.meta.env.PROD && import.meta.env.VITE_SENTRY_DSN) {
      Sentry.init({
        app,
        dsn: import.meta.env.VITE_SENTRY_DSN,
      })
    }

    app.use(createI18nInstance(localeFromPage(page)))
  },
})
