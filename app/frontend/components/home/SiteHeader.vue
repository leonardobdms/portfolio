<script setup lang="ts">
import { onKeyStroke } from "@vueuse/core"
import { Menu, X } from "lucide-vue-next"
import { computed, ref, watch } from "vue"
import { useI18n } from "vue-i18n"

import logo from "@/assets/images/logo.png"
import LocaleSwitcher from "@/components/LocaleSwitcher.vue"
import ThemeSwitcher from "@/components/ThemeSwitcher.vue"
import { Button } from "@/components/ui/button"
import { hasContact, hasResume, navItems } from "@/lib/home"
import type { Profile } from "@/types"

const props = withDefaults(
  defineProps<{
    profile: Profile
    basePath?: string
    activeSection?: string | null
  }>(),
  {
    basePath: "",
    activeSection: null,
  },
)

const { t } = useI18n()
const menuOpen = ref(false)
const menuButtonRef = ref<HTMLButtonElement | null>(null)
const items = computed(() => navItems(props.profile))

function closeMenu() {
  menuOpen.value = false
}

function navHref(href: string) {
  return `${props.basePath}${href}`
}

function navLabel(key: (typeof items.value)[number]["key"]) {
  return t(`home.nav.${key}`)
}

onKeyStroke("Escape", () => {
  if (!menuOpen.value) return
  closeMenu()
  menuButtonRef.value?.focus()
})

watch(menuOpen, (open) => {
  document.body.style.overflow = open ? "hidden" : ""
})
</script>

<template>
  <header
    class="border-border/80 bg-background/90 sticky top-0 z-20 h-16 border-b backdrop-blur-md"
  >
    <div
      class="mx-auto flex h-full max-w-7xl items-center justify-between gap-4 px-4 md:px-8"
    >
      <a
        :href="navHref('#top')"
        class="nav-link inline-flex items-center rounded-xl"
      >
        <img
          :src="logo"
          :alt="profile.name"
          width="32"
          height="32"
          class="size-8"
        />
      </a>

      <nav
        class="hidden items-center gap-6 lg:flex"
        :aria-label="t('home.mainNav')"
      >
        <a
          v-for="item in items"
          :key="item.href"
          :href="navHref(item.href)"
          :aria-current="activeSection === item.key ? 'true' : undefined"
          class="nav-link text-text-muted hover:text-text text-sm font-medium transition-colors"
        >
          {{ navLabel(item.key) }}
        </a>
      </nav>

      <div class="flex items-center gap-3">
        <LocaleSwitcher />
        <ThemeSwitcher />
        <Button
          v-if="hasResume(profile)"
          as="a"
          variant="outline"
          size="sm"
          class="hidden md:inline-flex"
          :href="profile.resume_url!"
          target="_blank"
          rel="noopener noreferrer"
        >
          {{ t("home.downloadResume") }}
        </Button>
        <Button
          v-if="hasContact(profile)"
          as="a"
          :href="navHref('#contact')"
          size="sm"
          class="hidden md:inline-flex"
        >
          {{ t("home.cta") }}
        </Button>
        <Button
          ref="menuButtonRef"
          class="lg:hidden"
          variant="outline"
          size="icon-sm"
          type="button"
          :aria-expanded="menuOpen"
          aria-controls="mobile-nav"
          :aria-label="menuOpen ? t('home.closeMenu') : t('home.openMenu')"
          @click="menuOpen = !menuOpen"
        >
          <X v-if="menuOpen" aria-hidden="true" :stroke-width="1.5" />
          <Menu v-else aria-hidden="true" :stroke-width="1.5" />
        </Button>
      </div>
    </div>

    <div
      v-if="menuOpen"
      id="mobile-nav"
      class="border-border bg-background absolute inset-x-0 top-16 border-b lg:hidden"
    >
      <nav
        class="mx-auto flex max-w-7xl flex-col gap-1 px-4 py-4"
        :aria-label="t('home.mainNav')"
      >
        <a
          v-for="item in items"
          :key="item.href"
          :href="navHref(item.href)"
          :aria-current="activeSection === item.key ? 'true' : undefined"
          class="nav-link text-text hover:bg-surface-light rounded-xl px-3 py-2 text-sm font-medium"
          @click="closeMenu"
        >
          {{ navLabel(item.key) }}
        </a>
        <Button
          v-if="hasResume(profile)"
          as="a"
          variant="outline"
          class="mt-2"
          :href="profile.resume_url!"
          target="_blank"
          rel="noopener noreferrer"
          @click="closeMenu"
        >
          {{ t("home.downloadResume") }}
        </Button>
        <Button
          v-if="hasContact(profile)"
          as="a"
          :href="navHref('#contact')"
          class="mt-2"
          @click="closeMenu"
        >
          {{ t("home.cta") }}
        </Button>
      </nav>
    </div>
  </header>
</template>
