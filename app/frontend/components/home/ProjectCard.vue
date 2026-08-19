<script setup lang="ts">
import { ExternalLink, Github } from "lucide-vue-next"

import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card"
import { cn } from "@/lib/utils"
import type { Project } from "@/types"

const props = defineProps<{
  project: Project
  large?: boolean
}>()

const hasLinks = Boolean(props.project.github_url || props.project.demo_url)
</script>

<template>
  <Card
    class="border-border bg-surface gap-0 overflow-hidden py-0 shadow-none transition-transform motion-safe:hover:-translate-y-0.5"
  >
    <div
      :class="
        cn(
          'bg-surface-light relative overflow-hidden',
          props.large ? 'aspect-[16/9]' : 'aspect-[16/10]',
        )
      "
    >
      <img
        v-if="project.image_url"
        :src="project.image_url"
        :alt="project.name"
        class="size-full object-cover"
      />
      <div
        v-else
        class="flex size-full items-end p-6 md:p-8"
        aria-hidden="true"
      >
        <p
          class="text-text/20 text-3xl font-semibold tracking-tighter md:text-4xl"
        >
          {{ project.name }}
        </p>
      </div>
    </div>

    <CardHeader class="pt-6 pb-4">
      <CardTitle class="text-text text-xl tracking-tight md:text-2xl">
        {{ project.name }}
      </CardTitle>
      <CardDescription
        v-if="project.short_description"
        class="text-text-muted max-w-[65ch] text-base leading-relaxed"
      >
        {{ project.short_description }}
      </CardDescription>
    </CardHeader>

    <CardContent
      v-if="project.skills.length > 0"
      :class="hasLinks ? 'flex flex-wrap gap-2' : 'flex flex-wrap gap-2 pb-6'"
    >
      <Badge
        v-for="skill in project.skills"
        :key="skill.id"
        variant="outline"
        class="border-border text-text-muted rounded-xl"
      >
        {{ skill.name }}
      </Badge>
    </CardContent>

    <CardFooter v-if="hasLinks" class="flex flex-wrap gap-2 pb-6">
      <Button
        v-if="project.github_url"
        as="a"
        variant="outline"
        size="sm"
        :href="project.github_url"
        target="_blank"
        rel="noopener noreferrer"
      >
        <Github :stroke-width="1.5" aria-hidden="true" />
        GitHub
      </Button>
      <Button
        v-if="project.demo_url"
        as="a"
        variant="outline"
        size="sm"
        :href="project.demo_url"
        target="_blank"
        rel="noopener noreferrer"
      >
        <ExternalLink :stroke-width="1.5" aria-hidden="true" />
        Demo
      </Button>
    </CardFooter>
  </Card>
</template>
