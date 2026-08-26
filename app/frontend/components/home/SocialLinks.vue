<script setup lang="ts">
import SocialIcon from "@/components/SocialIcon.vue"
import { Button } from "@/components/ui/button"
import type { ProfileSocial } from "@/lib/home"

const props = defineProps<{
  links: ProfileSocial[]
}>()
</script>

<template>
  <ul v-if="props.links.length > 0" class="flex flex-wrap items-center gap-2">
    <li v-for="link in props.links" :key="link.url">
      <Button
        as="a"
        variant="outline"
        size="icon"
        :href="link.url"
        target="_blank"
        rel="noopener noreferrer"
        :aria-label="link.label"
        class="group"
      >
        <SocialIcon :icon="link.icon ?? link.label" />
      </Button>
    </li>
  </ul>
</template>
