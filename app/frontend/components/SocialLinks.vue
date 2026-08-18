<script setup lang="ts">
import { ArrowUpRight, Github, Linkedin, Mail } from 'lucide-vue-next'
import type { Component } from 'vue'
import { usePortfolio } from '@/composables/usePortfolio'
import type { ContactKind } from '@/types'

const portfolio = usePortfolio()

const icons: Record<ContactKind, Component> = {
  github: Github,
  linkedin: Linkedin,
  email: Mail,
  other: Mail,
}
</script>

<template>
  <ul v-if="portfolio.contacts.length" class="flex flex-col gap-5">
    <li v-for="item in portfolio.contacts" :key="item.id">
      <a
        :href="item.href"
        class="group inline-flex items-start gap-3 text-ink no-underline transition-colors duration-200 ease-[var(--ease-out-strong)] hover-fine:text-accent active:scale-[0.99]"
        :target="item.external ? '_blank' : undefined"
        :rel="item.external ? 'noopener noreferrer' : undefined"
      >
        <component
          :is="icons[item.kind] ?? Mail"
          :stroke-width="1.5"
          class="mt-1 size-4 shrink-0 text-muted"
          aria-hidden="true"
        />
        <span class="flex min-w-0 flex-col">
          <span class="text-xs text-muted">{{ item.label }}</span>
          <span class="inline-flex items-center gap-1 text-[1.05rem] leading-snug">
            {{ item.value }}
            <ArrowUpRight
              v-if="item.external"
              :stroke-width="1.5"
              class="size-4 shrink-0 text-faint transition-colors duration-200 ease-[var(--ease-out-strong)] group-hover-fine:text-accent"
              aria-hidden="true"
            />
          </span>
        </span>
      </a>
    </li>
  </ul>
</template>
