<script setup lang="ts">
import { usePage } from "@inertiajs/vue3"
import { Moon, Sun } from "lucide-vue-next"
import { computed } from "vue"
import { useI18n } from "vue-i18n"

import { Button } from "@/components/ui/button"
import { normalizeTheme, themeSwitchPath } from "@/lib/theme"

const { t } = useI18n()
const page = usePage()
const currentTheme = computed(() => normalizeTheme(page.props.theme))

function isDark() {
  return currentTheme.value === "dark"
}
</script>

<template>
  <Button
    variant="outline"
    size="icon-sm"
    as="a"
    :href="themeSwitchPath(isDark() ? 'light' : 'dark')"
    :aria-label="isDark() ? t('theme.switchToLight') : t('theme.switchToDark')"
  >
    <Sun v-if="isDark()" aria-hidden="true" :stroke-width="1.5" />
    <Moon v-else aria-hidden="true" :stroke-width="1.5" />
  </Button>
</template>
