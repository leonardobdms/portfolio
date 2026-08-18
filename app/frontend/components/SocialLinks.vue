<script setup lang="ts">
import { Github, Linkedin, Mail } from 'lucide-vue-next'
import type { Component } from 'vue'
import { usePortfolio } from '@/composables/usePortfolio'
import { Button } from '@/components/ui/button'
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
  <ul v-if="portfolio.contacts.length" class="flex flex-wrap items-center gap-3">
    <li v-for="item in portfolio.contacts" :key="item.id">
      <Button variant="link" as-child class="h-auto px-0 text-muted">
        <a
          :href="item.href"
          :target="item.external ? '_blank' : undefined"
          :rel="item.external ? 'noopener noreferrer' : undefined"
        >
          <component
            :is="icons[item.kind] ?? Mail"
            :stroke-width="1.5"
            aria-hidden="true"
          />
          <span>{{ item.label }}</span>
        </a>
      </Button>
    </li>
  </ul>
</template>
