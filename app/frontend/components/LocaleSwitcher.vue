<script setup lang="ts">
import { usePage } from "@inertiajs/vue3"
import { computed } from "vue"
import { useI18n } from "vue-i18n"

import LocaleIcon from "@/components/LocaleIcon.vue"
import { Button } from "@/components/ui/button"
import {
  SUPPORTED_LOCALES,
  type SupportedLocale,
  localeSwitchPath,
  normalizeLocale,
} from "@/i18n"

const { t } = useI18n()
const page = usePage()
const currentLocale = computed(() => normalizeLocale(page.props.locale))

function localeLabel(locale: SupportedLocale): string {
  return locale === "en" ? t("locale.en") : t("locale.ptBR")
}

function localeAriaLabel(locale: SupportedLocale): string {
  return locale === "en" ? t("locale.switchToEn") : t("locale.switchToPtBR")
}
</script>

<template>
  <nav class="flex items-center gap-1" :aria-label="t('locale.label')">
    <Button
      v-for="locale in SUPPORTED_LOCALES"
      :key="locale"
      variant="outline"
      size="icon-sm"
      as="a"
      :href="localeSwitchPath(locale)"
      :class="
        currentLocale === locale
          ? 'border-primary ring-primary ring-1'
          : undefined
      "
      :aria-current="currentLocale === locale ? 'true' : undefined"
      :aria-label="localeAriaLabel(locale)"
      :title="localeLabel(locale)"
    >
      <LocaleIcon :locale="locale" />
    </Button>
  </nav>
</template>
