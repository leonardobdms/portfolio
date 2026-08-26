<script setup lang="ts">
import { usePage } from "@inertiajs/vue3"
import { computed } from "vue"

import { Toaster } from "@/components/ui/sonner"

const page = usePage()
const toasterTheme = computed(() =>
  page.props.theme === "light" ? "light" : "dark",
)
</script>

<template>
  <slot />
  <Toaster
    position="top-right"
    :theme="toasterTheme"
    rich-colors
    close-button
  />
</template>
