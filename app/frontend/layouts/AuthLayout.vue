<script setup lang="ts">
import ThemeToggle from '@/components/ThemeToggle.vue'
</script>

<template>
  <div class="relative min-h-[100dvh] overflow-x-clip bg-bg text-ink">
    <div class="absolute top-4 right-4 z-40">
      <ThemeToggle />
    </div>
    <main class="flex min-h-[100dvh] items-center justify-center px-4 py-16">
      <div class="w-full max-w-[26rem]">
        <slot />
      </div>
    </main>
    <div class="page-grain" aria-hidden="true" />
  </div>
</template>
