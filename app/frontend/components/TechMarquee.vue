<script setup lang="ts">
import { usePortfolio } from '@/composables/usePortfolio'
import TechChip from '@/components/TechChip.vue'

const portfolio = usePortfolio()
</script>

<template>
  <div
    v-if="portfolio.skills.length"
    class="overflow-hidden border-y border-line py-5"
    :aria-label="$t('skills.title')"
  >
    <ul
      class="flex w-max animate-marquee gap-12 pr-12 font-mono text-sm text-faint motion-reduce:animate-none hover-fine:[animation-play-state:paused]"
    >
      <li
        v-for="(skill, index) in [...portfolio.skills, ...portfolio.skills]"
        :key="skill.id + '-' + index"
        class="shrink-0"
      >
        <TechChip :item="skill" />
      </li>
    </ul>
  </div>
</template>
