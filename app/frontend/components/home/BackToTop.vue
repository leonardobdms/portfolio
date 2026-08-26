<script setup lang="ts">
import { ArrowUp } from "lucide-vue-next"
import { onMounted, onUnmounted, ref } from "vue"
import { useI18n } from "vue-i18n"

import { Button } from "@/components/ui/button"

const { t } = useI18n()
const visible = ref(false)

function onScroll() {
  visible.value = window.scrollY > 480
}

onMounted(() => {
  window.addEventListener("scroll", onScroll, { passive: true })
  onScroll()
})

onUnmounted(() => {
  window.removeEventListener("scroll", onScroll)
})
</script>

<template>
  <Button
    v-if="visible"
    as="a"
    href="#top"
    variant="outline"
    size="icon"
    class="border-border bg-surface/90 fixed right-4 bottom-4 z-20 backdrop-blur-md md:right-8"
    :aria-label="t('home.backToTop')"
  >
    <ArrowUp aria-hidden="true" :stroke-width="1.5" />
  </Button>
</template>
