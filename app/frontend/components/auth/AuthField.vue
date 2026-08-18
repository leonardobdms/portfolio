<script setup lang="ts">
import type { HTMLAttributes } from 'vue'
import { cn } from '@/lib/utils'

defineOptions({ inheritAttrs: false })

const props = withDefaults(
  defineProps<{
    id: string
    label: string
    error?: string
    type?: string
    class?: HTMLAttributes['class']
  }>(),
  {
    type: 'text',
  },
)

const model = defineModel<string>({ required: true })
</script>

<template>
  <div class="grid gap-2">
    <label :for="id" class="text-sm text-muted">
      {{ label }}
    </label>
    <input
      :id="id"
      v-model="model"
      :type="type"
      :aria-invalid="error ? true : undefined"
      :aria-describedby="error ? `${id}-error` : undefined"
      :class="cn(
        'h-10 w-full rounded-[var(--radius-sm)] border border-line bg-bg px-3 text-sm text-ink outline-none transition-colors',
        'placeholder:text-faint focus-visible:border-accent focus-visible:ring-3 focus-visible:ring-accent/30',
        error && 'border-destructive',
        props.class,
      )"
      v-bind="$attrs"
    >
    <p v-if="error" :id="`${id}-error`" class="text-sm text-destructive">
      {{ error }}
    </p>
  </div>
</template>
