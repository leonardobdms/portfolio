import { ref } from 'vue'
import { applyTheme, getInitialTheme, persistTheme, type Theme } from './theme'

const theme = ref<Theme>(getInitialTheme())

export function useTheme() {
  function setTheme(next: Theme) {
    theme.value = next
    applyTheme(next)
    persistTheme(next)
  }

  function toggleTheme() {
    setTheme(theme.value === 'dark' ? 'light' : 'dark')
  }

  return {
    theme,
    setTheme,
    toggleTheme,
  }
}
