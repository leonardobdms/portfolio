<script setup lang="ts">
import { Menu, X } from "lucide-vue-next"
import { computed, ref } from "vue"
import { useI18n } from "vue-i18n"

import logo from "@/assets/images/logo.png"
import LocaleSwitcher from "@/components/LocaleSwitcher.vue"
import { Button } from "@/components/ui/button"
import { hasContact, navItems } from "@/lib/home"
import type { Profile } from "@/types"

const props = defineProps<{
  profile: Profile
}>()

const { t } = useI18n()
const menuOpen = ref(false)
const items = computed(() => navItems(props.profile))

function closeMenu() {
  menuOpen.value = false
}

function navLabel(key: (typeof items.value)[number]["key"]) {
  return t(`home.nav.${key}`)
}
</script>

<template>
  <header
    class="border-border/80 bg-background/90 sticky top-0 z-20 h-16 border-b backdrop-blur-md"
  >
    <div
      class="mx-auto flex h-full max-w-7xl items-center justify-between gap-4 px-4 md:px-8"
    >
      <a
        href="#top"
        class="focus-visible:ring-primary focus-visible:ring-offset-background inline-flex items-center rounded-xl focus-visible:ring-2 focus-visible:ring-offset-2 focus-visible:outline-none"
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
          :href="item.href"
          class="text-text-muted hover:text-text text-sm font-medium transition-colors"
        >
          {{ navLabel(item.key) }}
        </a>
      </nav>

      <div class="flex items-center gap-3">
        <LocaleSwitcher />
        <Button
          v-if="hasContact(profile)"
          as="a"
          href="#contact"
          size="sm"
          class="hidden md:inline-flex"
        >
          {{ t("home.cta") }}
        </Button>
        <Button
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
          :href="item.href"
          class="text-text hover:bg-surface-light rounded-xl px-3 py-2 text-sm font-medium"
          @click="closeMenu"
        >
          {{ navLabel(item.key) }}
        </a>
        <Button
          v-if="hasContact(profile)"
          as="a"
          href="#contact"
          class="mt-2"
          @click="closeMenu"
        >
          {{ t("home.cta") }}
        </Button>
      </nav>
    </div>
  </header>
</template>
