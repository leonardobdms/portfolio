<script setup lang="ts">
import { Code2 } from 'lucide-vue-next'
import { computed } from 'vue'
import { techGlyph } from '@/media/techIcons'

const props = defineProps<{
  slug: string
  label: string
}>()

const glyph = computed(() => techGlyph(props.slug))
</script>

<template>
  <svg
    v-if="glyph"
    class="size-[1em] shrink-0"
    role="img"
    viewBox="0 0 24 24"
    aria-hidden="true"
  >
    <title>{{ label }}</title>
    <path :d="glyph.path" fill="currentColor" />
  </svg>
  <Code2 v-else class="size-[1em] shrink-0" :stroke-width="1.6" aria-hidden="true" />
</template>
