<script setup lang="ts">
import Footer from '@/components/Footer.vue'
import Navbar from '@/components/Navbar.vue'
</script>

<template>
  <div class="relative overflow-x-clip bg-bg text-ink">
    <div id="nav-sentinel" class="pointer-events-none absolute top-0 h-px w-full" aria-hidden="true" />
    <a
      class="absolute top-0 left-4 z-[60] -translate-y-[120%] rounded-lg bg-ink px-3.5 py-2 text-sm text-bg no-underline focus:translate-y-4"
      href="#conteudo"
    >
      {{ $t('a11y.skipToContent') }}
    </a>
    <Navbar />
    <main id="conteudo" class="w-full max-w-full overflow-x-clip">
      <slot />
    </main>
    <Footer />
    <div class="page-grain" aria-hidden="true" />
  </div>
</template>
