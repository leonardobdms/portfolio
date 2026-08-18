<script setup lang="ts">
import { ArrowUpRight, Github } from 'lucide-vue-next'
import type { HTMLAttributes } from 'vue'
import type { ProjectItem } from '@/types'
import { stillForProject } from '@/media/stills'
import { cn } from '@/lib/utils'
import MediaStill from '@/components/MediaStill.vue'
import TechChip from '@/components/TechChip.vue'
import { Button } from '@/components/ui/button'
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from '@/components/ui/card'

const props = withDefaults(
  defineProps<{
    project: ProjectItem
    featured?: boolean
    showMedia?: boolean
    class?: HTMLAttributes['class']
  }>(),
  { featured: false, showMedia: false },
)
</script>

<template>
  <Card
    :id="project.slug"
    :class="cn(
      'min-w-0 border-line bg-surface shadow-none ring-0',
      showMedia && 'pt-0! pb-4',
      featured && 'md:col-span-2',
      props.class,
    )"
  >
    <MediaStill
      v-if="showMedia"
      class="aspect-[16/10] rounded-none border-0"
      :class="featured ? 'md:aspect-[21/9]' : undefined"
      :still="stillForProject(project.slug)"
      :alt="$t('media.project', { name: project.name })"
      :sizes="featured ? '(min-width: 768px) 70vw, 100vw' : '(min-width: 768px) 42vw, 100vw'"
    />
    <CardHeader>
      <CardTitle
        class="tracking-tight text-ink"
        :class="featured ? 'text-2xl md:text-[1.75rem]' : 'text-lg'"
      >
        {{ project.name }}
      </CardTitle>
      <p v-if="project.role" class="font-mono text-xs text-faint">
        {{ project.role }}
      </p>
    </CardHeader>
    <CardContent class="flex flex-col gap-4">
      <CardDescription
        class="text-pretty text-muted"
        :class="featured ? 'max-w-[60ch] text-[1.05rem] leading-relaxed' : 'leading-relaxed'"
      >
        {{ project.summary }}
      </CardDescription>
      <ul
        v-if="project.technologies.length"
        class="flex flex-wrap gap-2"
        :aria-label="$t('a11y.projectTechnologies', { name: project.name })"
      >
        <li v-for="tech in project.technologies" :key="tech.name">
          <TechChip :item="tech" />
        </li>
      </ul>
    </CardContent>
    <CardFooter
      v-if="project.url.trim() || project.github.trim()"
      class="border-line bg-transparent"
    >
      <div class="flex flex-wrap gap-x-2 gap-y-1">
        <Button v-if="project.url.trim()" variant="link" as-child class="h-auto px-0">
          <a :href="project.url" target="_blank" rel="noopener noreferrer">
            {{ $t('projects.viewProject') }}
            <ArrowUpRight :stroke-width="1.5" aria-hidden="true" />
          </a>
        </Button>
        <Button v-if="project.github.trim()" variant="link" as-child class="h-auto px-0">
          <a :href="project.github" target="_blank" rel="noopener noreferrer">
            {{ $t('projects.github') }}
            <Github :stroke-width="1.5" aria-hidden="true" />
          </a>
        </Button>
      </div>
    </CardFooter>
  </Card>
</template>
