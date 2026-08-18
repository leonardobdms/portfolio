<script setup lang="ts">
import type { HTMLAttributes } from 'vue'
import type { HeadingVariants } from '.'
import { cn } from '@/lib/utils'
import { headingVariants } from '.'

const props = withDefaults(
  defineProps<{
    as?: 'h1' | 'h2' | 'h3' | 'h4'
    variant?: HeadingVariants['variant']
    class?: HTMLAttributes['class']
  }>(),
  {
    as: 'h2',
    variant: 'section',
  },
)
</script>

<template>
  <component :is="as" :class="cn(headingVariants({ variant }), props.class)">
    <slot />
  </component>
</template>
