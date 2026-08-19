<script setup lang="ts">
import { onBeforeUnmount, onMounted, ref } from "vue"

import { cn } from "@/lib/utils"

const props = defineProps<{
  class?: string
}>()

const el = ref<HTMLElement | null>(null)
const visible = ref(false)
let observer: IntersectionObserver | null = null

onMounted(() => {
  if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) {
    visible.value = true
    return
  }

  observer = new IntersectionObserver(
    ([entry]) => {
      if (entry?.isIntersecting) {
        visible.value = true
        observer?.disconnect()
      }
    },
    { threshold: 0.14, rootMargin: "0px 0px -6% 0px" },
  )

  if (el.value) observer.observe(el.value)
})

onBeforeUnmount(() => {
  observer?.disconnect()
})
</script>

<template>
  <div
    ref="el"
    :class="
      cn(
        'transition-all duration-700 ease-out motion-reduce:translate-y-0 motion-reduce:opacity-100',
        visible ? 'translate-y-0 opacity-100' : 'translate-y-4 opacity-0',
        props.class,
      )
    "
  >
    <slot />
  </div>
</template>
