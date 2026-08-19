import { createInertiaApp } from "@inertiajs/vue3"

import { createI18nInstance, localeFromPage } from "@/i18n"

createInertiaApp({
  pages: "../pages",
  defaults: {
    form: {
      forceIndicesArrayFormatInFormData: false,
      withAllErrors: true,
    },
    visitOptions: () => ({
      queryStringArrayFormat: "brackets",
    }),
  },
  withApp(app, { page }) {
    app.use(createI18nInstance(localeFromPage(page)))
  },
})
