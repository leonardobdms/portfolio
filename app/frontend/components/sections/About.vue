<script setup lang="ts">
import { ABOUT_STILL } from '@/media/stills'
import { usePortfolio } from '@/composables/usePortfolio'
import { Heading } from '@/components/heading'
import MediaStill from '@/components/MediaStill.vue'

const portfolio = usePortfolio()
</script>

<template>
  <section id="sobre" class="py-20 md:py-28" aria-labelledby="sobre-title">
    <div class="shell grid items-center gap-10 lg:grid-cols-12 lg:gap-14">
      <div class="lg:col-span-6">
        <Heading id="sobre-title">
          {{ $t('about.title') }}
        </Heading>
        <div class="mt-6 max-w-[65ch] space-y-5 text-[1.05rem] leading-relaxed text-pretty text-muted">
          <p v-for="(paragraph, index) in portfolio.profile.about" :key="index">
            {{ paragraph }}
          </p>
        </div>
      </div>
      <MediaStill
        class="aspect-[4/3] w-full lg:col-span-6"
        :still="ABOUT_STILL"
        :alt="$t(ABOUT_STILL.altKey)"
        sizes="(min-width: 1024px) 44vw, 100vw"
      />
    </div>
  </section>
</template>
