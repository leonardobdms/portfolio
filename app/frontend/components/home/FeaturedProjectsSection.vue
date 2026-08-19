<script setup lang="ts">
import { useI18n } from "vue-i18n"

import HomeSection from "@/components/home/HomeSection.vue"
import ProjectCard from "@/components/home/ProjectCard.vue"
import Reveal from "@/components/home/Reveal.vue"
import type { Project } from "@/types"

defineProps<{
  projects: Project[]
}>()

const { t } = useI18n()
</script>

<template>
  <HomeSection id="projects" :title="t('home.projectsTitle')">
    <div class="grid gap-6 lg:grid-cols-5">
      <Reveal
        v-for="(project, index) in projects"
        :key="project.id"
        :class="
          projects.length === 1
            ? 'lg:col-span-5'
            : index === 0
              ? 'lg:col-span-3'
              : 'lg:col-span-2'
        "
      >
        <ProjectCard :project="project" :large="index === 0" />
      </Reveal>
    </div>
  </HomeSection>
</template>
