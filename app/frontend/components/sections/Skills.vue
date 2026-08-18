<script setup lang="ts">
import { computed } from 'vue'
import { usePortfolio } from '@/composables/usePortfolio'
import { Heading } from '@/components/heading'
import TechMarquee from '@/components/TechMarquee.vue'
import TechChip from '@/components/TechChip.vue'

const portfolio = usePortfolio()
const featuredSkills = computed(() =>
  portfolio.value.skills.filter((skill) => skill.level === 'featured'),
)
</script>

<template>
  <section id="tecnologias" class="py-20 md:py-28" aria-labelledby="tecnologias-title">
    <div class="shell">
      <Heading id="tecnologias-title">
        {{ $t('skills.title') }}
      </Heading>

      <p v-if="!portfolio.skills.length" class="mt-8 max-w-[65ch] text-muted">
        {{ $t('empty.skills') }}
      </p>
    </div>

    <div v-if="portfolio.skills.length" class="mt-10">
      <TechMarquee />
    </div>

    <div v-if="featuredSkills.length" class="shell">
      <ul class="reveal mt-10 flex flex-wrap gap-2">
        <li v-for="skill in featuredSkills" :key="skill.id">
          <TechChip :item="skill" />
        </li>
      </ul>
    </div>
  </section>
</template>
