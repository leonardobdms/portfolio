<script setup lang="ts">
import { Github, Globe, Linkedin } from "lucide-vue-next"
import type { Component } from "vue"

import { Button } from "@/components/ui/button"
import type { ProfileSocial } from "@/lib/home"

const props = defineProps<{
  links: ProfileSocial[]
}>()

function iconFor(link: ProfileSocial): Component {
  const key = (link.icon ?? link.label).toLowerCase()

  if (key.includes("github")) return Github
  if (key.includes("linkedin")) return Linkedin
  return Globe
}
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
      >
        <component :is="iconFor(link)" :stroke-width="1.5" aria-hidden="true" />
      </Button>
    </li>
  </ul>
</template>
