<script setup lang="ts">
import { CONTACT_STILL } from '@/media/stills'
import { usePortfolio } from '@/composables/usePortfolio'
import { Heading } from '@/components/heading'
import SocialLinks from '@/components/SocialLinks.vue'
import MediaStill from '@/components/MediaStill.vue'

const portfolio = usePortfolio()
</script>

<template>
  <section id="contato" class="py-20 md:py-28" aria-labelledby="contato-title">
    <div class="shell grid items-center gap-10 lg:grid-cols-12 lg:gap-14">
      <div class="reveal lg:col-span-6">
        <div class="max-w-xl">
          <Heading id="contato-title" variant="lead">
            {{ portfolio.profile.contactTitle }}
          </Heading>
          <p class="mt-5 max-w-[40ch] text-lg leading-relaxed text-pretty text-muted">
            {{ portfolio.profile.contactText }}
          </p>
          <div class="mt-8">
            <SocialLinks />
          </div>
        </div>
      </div>
      <MediaStill
        class="aspect-[4/3] w-full lg:col-span-6"
        :still="CONTACT_STILL"
        :alt="$t(CONTACT_STILL.altKey)"
        sizes="(min-width: 1024px) 42vw, 100vw"
      />
    </div>
  </section>
</template>
