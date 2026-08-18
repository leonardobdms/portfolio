<script setup lang="ts">
import { ArrowRight } from 'lucide-vue-next'
import { HERO_STILL } from '@/media/stills'
import { usePortfolio } from '@/composables/usePortfolio'
import MediaStill from '@/components/MediaStill.vue'
import { Heading } from '@/components/heading'
import TechChip from '@/components/TechChip.vue'
import { Button } from '@/components/ui/button'

const portfolio = usePortfolio()
</script>

<template>
  <section
    id="topo"
    class="flex min-h-[100dvh] items-center pt-20 pb-16 md:pt-24 md:pb-20"
    aria-labelledby="hero-title"
  >
    <div class="shell grid items-center gap-10 lg:grid-cols-12 lg:gap-14">
      <div class="lg:col-span-6">
        <Heading id="hero-title" as="h1" variant="hero">
          {{ portfolio.profile.headline }}
        </Heading>
        <ul
          v-if="portfolio.profile.highlights.length"
          class="mt-5 flex flex-wrap gap-2"
          :aria-label="$t('a11y.techFocus')"
        >
          <li v-for="item in portfolio.profile.highlights" :key="item.name">
            <TechChip :item="item" />
          </li>
        </ul>
        <p class="mt-6 max-w-[38rem] text-base leading-relaxed text-pretty text-muted md:text-[1.05rem]">
          {{ portfolio.profile.intro }}
        </p>
        <div class="mt-8">
          <Button variant="link" as-child class="h-auto px-0 text-ink">
            <a href="#projetos">
              {{ $t('hero.viewProjects') }}
              <ArrowRight :stroke-width="1.5" aria-hidden="true" />
            </a>
          </Button>
        </div>
      </div>
      <MediaStill
        class="aspect-[16/10] w-full lg:col-span-6"
        :still="HERO_STILL"
        :alt="$t(HERO_STILL.altKey)"
        sizes="(min-width: 1024px) 44vw, 100vw"
        priority
      />
    </div>
  </section>
</template>
