<script setup lang="ts">
import { computed, onUnmounted, ref, watch } from 'vue'
import { onClickOutside, onKeyStroke, useMediaQuery } from '@vueuse/core'
import { NAV_ITEMS } from '@/types'
import { useNavSpy } from '@/composables/useNavSpy'
import { usePortfolio } from '@/composables/usePortfolio'
import ThemeToggle from '@/components/ThemeToggle.vue'

const portfolio = usePortfolio()
const { scrolled, activeHref, activate } = useNavSpy()

const menuOpen = ref(false)
const shellRef = ref<HTMLElement | null>(null)
const isDesktop = useMediaQuery('(min-width: 1024px)')

onClickOutside(shellRef, () => {
  menuOpen.value = false
})

onKeyStroke('Escape', () => {
  menuOpen.value = false
})

watch(isDesktop, (desktop) => {
  if (desktop) {
    menuOpen.value = false
  }
})

watch(menuOpen, (open) => {
  document.documentElement.style.overflow = open ? 'hidden' : ''
})

onUnmounted(() => {
  document.documentElement.style.overflow = ''
})

const elevated = computed(() => scrolled.value || menuOpen.value)

function toggleMenu() {
  menuOpen.value = !menuOpen.value
}

function onNavClick(href: string) {
  activate(href)
  menuOpen.value = false
}
</script>

<template>
  <header class="fixed inset-x-0 top-0 z-40 px-4 pt-3">
    <div
      ref="shellRef"
      class="nav-glass mx-auto w-full max-w-[70rem]"
      :data-scrolled="elevated ? 'true' : 'false'"
      :data-open="menuOpen ? 'true' : 'false'"
    >
      <div class="grid h-12 grid-cols-[1fr_auto] items-center gap-3 px-3.5 lg:grid-cols-[1fr_auto_1fr] lg:px-4">
        <a
          href="#topo"
          class="justify-self-start text-[0.95rem] font-medium tracking-[-0.03em] text-ink no-underline transition-colors duration-200 hover-fine:text-accent"
          @click="onNavClick('#topo')"
        >
          {{ portfolio.profile.shortName }}
        </a>

        <nav
          class="hidden items-center lg:flex"
          :aria-label="$t('a11y.mainNav')"
        >
          <a
            v-for="item in NAV_ITEMS"
            :key="item.href"
            :href="item.href"
            class="nav-link"
            :aria-current="activeHref === item.href ? 'location' : undefined"
            @click="onNavClick(item.href)"
          >
            {{ $t(item.labelKey) }}
          </a>
        </nav>

        <div class="flex items-center justify-self-end gap-0.5">
          <ThemeToggle />
          <button
            type="button"
            class="nav-menu-btn lg:hidden"
            :aria-expanded="menuOpen"
            aria-controls="mobile-nav"
            :aria-label="menuOpen ? $t('a11y.closeMenu') : $t('a11y.openMenu')"
            @click="toggleMenu"
          >
            <span class="nav-menu-icon" :data-open="menuOpen ? 'true' : 'false'" aria-hidden="true">
              <span />
              <span />
            </span>
          </button>
        </div>
      </div>

      <div class="nav-mobile-fold lg:hidden" :data-open="menuOpen ? 'true' : 'false'">
        <div class="min-h-0 overflow-hidden">
          <nav
            id="mobile-nav"
            class="border-t border-line/70 px-2.5 pt-2 pb-3"
            :aria-label="$t('a11y.mobileNav')"
            :aria-hidden="!menuOpen"
            :inert="!menuOpen"
          >
            <ul class="flex flex-col">
              <li
                v-for="(item, index) in NAV_ITEMS"
                :key="item.href"
                :style="{ '--i': index }"
              >
                <a
                  :href="item.href"
                  class="nav-mobile-link"
                  :aria-current="activeHref === item.href ? 'location' : undefined"
                  @click="onNavClick(item.href)"
                >
                  {{ $t(item.labelKey) }}
                </a>
              </li>
            </ul>
          </nav>
        </div>
      </div>
    </div>
  </header>
</template>
