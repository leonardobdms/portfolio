<script setup lang="ts">
defineProps<{
  id: string
  title: string
}>()
</script>

<template>
  <section
    :id="id"
    class="mx-auto max-w-7xl scroll-mt-24 px-4 py-16 md:px-8 md:py-24"
  >
    <h2 class="text-text text-3xl font-semibold tracking-tight md:text-4xl">
      {{ title }}
    </h2>
    <div class="mt-10">
      <slot />
    </div>
  </section>
</template>
