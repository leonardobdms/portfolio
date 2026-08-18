<script setup lang="ts">
import { Head } from '@inertiajs/vue3'
import AppLayout from '@/layouts/AppLayout.vue'
import About from '@/components/sections/About.vue'
import Contact from '@/components/sections/Contact.vue'
import Experience from '@/components/sections/Experience.vue'
import Hero from '@/components/sections/Hero.vue'
import Projects from '@/components/sections/Projects.vue'
import Skills from '@/components/sections/Skills.vue'
import type { PortfolioPayload } from '@/types'

defineProps<{
  portfolio: PortfolioPayload
}>()
</script>

<template>
  <AppLayout>
    <Head>
      <title>{{ portfolio.profile.name }} | {{ portfolio.profile.headline }}</title>
      <meta name="description" :content="portfolio.profile.seoDescription" />
    </Head>
    <Hero />
    <About />
    <Experience />
    <Projects />
    <Skills />
    <Contact />
  </AppLayout>
</template>
