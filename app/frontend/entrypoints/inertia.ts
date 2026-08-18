import { createInertiaApp } from '@inertiajs/vue3'
import { createApp, h, type DefineComponent } from 'vue'
import { applyTheme, getInitialTheme } from '../composables/theme'
import { i18n, setLocale } from '../i18n'
import '../style.css'

applyTheme(getInitialTheme())

createInertiaApp({
  resolve: (name) => {
    const pages = import.meta.glob<{ default: DefineComponent }>('../pages/**/*.vue', {
      eager: true,
    })
    const page = pages[`../pages/${name}.vue`]
    if (!page) {
      throw new Error(`Page not found: ${name}`)
    }
    return page.default
  },
  setup({ el, App, props, plugin }) {
    const locale = setLocale((props.initialPage.props.locale as string | undefined) ?? 'pt-BR')
    document.documentElement.lang = locale

    const app = createApp({ render: () => h(App, props) })
    app.use(plugin)
    app.use(i18n)
    app.mount(el)
  },
}).catch((error) => {
  if (document.getElementById('app')) {
    throw error
  }
  console.error(error)
})
