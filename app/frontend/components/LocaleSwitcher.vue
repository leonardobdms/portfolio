<template>
  <nav
    class="flex items-center gap-2 text-sm font-medium"
    :aria-label="t('locale.label')"
  >
    <a
      :href="localeSwitchPath('en')"
      :aria-current="currentLocale === 'en' ? 'true' : undefined"
      :class="linkClass('en')"
    >
      {{ t("locale.en") }}
    </a>
    <span aria-hidden="true">/</span>
    <a
      :href="localeSwitchPath('pt-BR')"
      :aria-current="currentLocale === 'pt-BR' ? 'true' : undefined"
      :class="linkClass('pt-BR')"
    >
      {{ t("locale.ptBR") }}
    </a>
  </nav>
</template>

<script setup lang="ts">
import { usePage } from "@inertiajs/vue3"
import { computed } from "vue"
import { useI18n } from "vue-i18n"

import { type SupportedLocale, localeSwitchPath, normalizeLocale } from "@/i18n"

const { t } = useI18n()
const page = usePage()
const currentLocale = computed(() => normalizeLocale(page.props.locale))

function linkClass(locale: SupportedLocale) {
  return currentLocale.value === locale
    ? "opacity-100 underline underline-offset-4"
    : "opacity-50 hover:opacity-100"
}
</script>
