<script setup lang="ts">
import { ArrowUpRight } from 'lucide-vue-next'
import { usePortfolio } from '@/composables/usePortfolio'
import { Heading } from '@/components/heading'
import TechChip from '@/components/TechChip.vue'
import { Button } from '@/components/ui/button'
import { Separator } from '@/components/ui/separator'

const portfolio = usePortfolio()
</script>

<template>
  <section id="experiencia" class="py-20 md:py-28" aria-labelledby="experiencia-title">
    <div class="shell">
      <Heading id="experiencia-title">
        {{ $t('experience.title') }}
      </Heading>

      <p v-if="!portfolio.experiences.length" class="mt-8 max-w-[65ch] text-muted">
        {{ $t('empty.experience') }}
      </p>

      <ol v-else class="mt-10 max-w-3xl">
        <li v-for="(item, index) in portfolio.experiences" :key="item.id">
          <Separator v-if="index > 0" class="bg-line" />
          <div class="reveal grid gap-2 py-10 first:pt-0 last:pb-0 md:grid-cols-[11rem_minmax(0,1fr)] md:gap-10">
            <p class="font-mono text-xs text-faint md:pt-2">
              {{ item.period }}
            </p>
            <div>
              <Heading as="h3" variant="item">
                {{ item.role }}
              </Heading>
              <Button
                v-if="item.company && item.url.trim()"
                variant="link"
                as-child
                class="mt-1 h-auto px-0 text-muted"
              >
                <a
                  :href="item.url"
                  target="_blank"
                  rel="noopener noreferrer"
                  :aria-label="$t('experience.visitCompany', { company: item.company })"
                >
                  {{ item.company }}
                  <ArrowUpRight :stroke-width="1.5" aria-hidden="true" />
                </a>
              </Button>
              <p v-else-if="item.company" class="mt-1 text-sm text-muted">
                {{ item.company }}
              </p>
              <p class="mt-4 max-w-[65ch] leading-relaxed text-pretty text-muted">
                {{ item.description }}
              </p>
              <ul
                v-if="item.technologies.length"
                class="mt-5 flex flex-wrap gap-2"
                :aria-label="$t('a11y.usedTechnologies')"
              >
                <li v-for="tech in item.technologies" :key="tech.name">
                  <TechChip :item="tech" />
                </li>
              </ul>
            </div>
          </div>
        </li>
      </ol>
    </div>
  </section>
</template>
