<script setup lang="ts">
import type { NamedIcon } from '@/types'
import TechIcon from '@/components/TechIcon.vue'
import { Badge } from '@/components/ui/badge'

defineProps<{
  item: NamedIcon
}>()
</script>

<template>
  <Badge
    variant="outline"
    class="h-auto gap-1.5 rounded-md border-line bg-surface font-mono text-[0.6875rem] font-normal tracking-[0.01em] text-muted"
  >
    <TechIcon v-if="item.icon" :slug="item.icon" :label="item.name" />
    <span>{{ item.name }}</span>
  </Badge>
</template>
