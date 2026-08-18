<script setup lang="ts">
import { usePortfolio } from '@/composables/usePortfolio'
import { Heading } from '@/components/heading'
import ProjectCard from '@/components/ProjectCard.vue'

const portfolio = usePortfolio()
</script>

<template>
  <section id="projetos" class="pt-20 pb-16 md:pt-28 md:pb-20" aria-labelledby="projetos-title">
    <div class="shell">
      <Heading id="projetos-title">
        {{ $t('projects.title') }}
      </Heading>

      <p v-if="!portfolio.projects.length" class="mt-8 max-w-[65ch] text-muted">
        {{ $t('empty.projects') }}
      </p>

      <div v-else class="mt-12 grid gap-6 md:grid-cols-2">
        <ProjectCard
          v-for="(project, index) in portfolio.projects"
          :key="project.id"
          :project="project"
          :featured="index === 0"
          show-media
        />
      </div>
    </div>
  </section>
</template>
