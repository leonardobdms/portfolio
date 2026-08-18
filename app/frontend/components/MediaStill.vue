<script setup lang="ts">
import type { Still } from '@/media/stills'

withDefaults(
  defineProps<{
    still: Still
    alt: string
    sizes?: string
    priority?: boolean
  }>(),
  {
    sizes: '(min-width: 1024px) 42vw, 100vw',
    priority: false,
  },
)
</script>

<template>
  <figure class="group overflow-hidden border border-line bg-surface">
    <img
      :src="still.src"
      :alt="alt"
      :width="still.width"
      :height="still.height"
      :sizes="sizes"
      :fetchpriority="priority ? 'high' : 'low'"
      :loading="priority ? 'eager' : 'lazy'"
      decoding="async"
      class="h-full w-full object-cover contrast-[1.04] transition-transform duration-700 ease-out motion-reduce:transition-none group-hover:scale-105 motion-reduce:group-hover:scale-100"
    />
  </figure>
</template>
