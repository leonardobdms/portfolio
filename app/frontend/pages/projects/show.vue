<template>
  <Head :title="`${project.name} | ${profile.name}`">
    <meta
      head-key="description"
      name="description"
      :content="metaDescription"
    />
    <meta head-key="og:title" property="og:title" :content="project.name" />
    <meta
      head-key="og:description"
      property="og:description"
      :content="metaDescription"
    />
    <meta head-key="og:type" property="og:type" content="article" />
    <meta head-key="og:url" property="og:url" :content="canonicalUrl" />
    <meta
      head-key="og:image"
      property="og:image"
      :content="project.image_url || ogImageUrl"
    />
    <link head-key="canonical" rel="canonical" :href="canonicalUrl" />
  </Head>

  <PublicLayout :profile="profile" base-path="/">
    <section class="mx-auto max-w-7xl px-4 py-16 md:px-8 md:py-24">
      <p class="text-text-muted text-sm">
        <a href="/#projects" class="nav-link">{{ t("home.projectsTitle") }}</a>
      </p>

      <h1
        class="text-text mt-4 text-4xl font-semibold tracking-tighter text-balance md:text-5xl"
      >
        {{ project.name }}
      </h1>

      <p
        v-if="project.short_description"
        class="text-text-muted mt-4 max-w-[65ch] text-lg leading-relaxed text-pretty"
      >
        {{ project.short_description }}
      </p>

      <div class="mt-6 flex flex-wrap gap-3">
        <Button
          v-if="project.github_url"
          as="a"
          variant="outline"
          :href="project.github_url"
          target="_blank"
          rel="noopener noreferrer"
        >
          <Github aria-hidden="true" :stroke-width="1.5" />
          GitHub
        </Button>
        <Button
          v-if="project.demo_url"
          as="a"
          variant="outline"
          :href="project.demo_url"
          target="_blank"
          rel="noopener noreferrer"
        >
          <ExternalLink aria-hidden="true" :stroke-width="1.5" />
          Demo
        </Button>
      </div>

      <div v-if="project.skills.length > 0" class="mt-8 flex flex-wrap gap-2">
        <Badge
          v-for="skill in project.skills"
          :key="skill.id"
          variant="outline"
          class="border-border text-text-muted group inline-flex items-center gap-1.5 rounded-xl"
        >
          <SkillIcon
            :icon="skill.icon"
            :category="skill.category"
            class="size-3.5"
          />
          {{ skill.name }}
        </Badge>
      </div>

      <div
        v-if="descriptionParagraphs.length > 0"
        class="text-text-muted mt-10 max-w-[65ch] space-y-4 leading-relaxed text-pretty"
      >
        <p v-for="(paragraph, index) in descriptionParagraphs" :key="index">
          {{ paragraph }}
        </p>
      </div>

      <nav
        class="border-border mt-12 flex flex-wrap gap-4 border-t pt-8"
        aria-label="Project navigation"
      >
        <a
          v-if="previousSlug"
          :href="projects.show(previousSlug).url"
          class="nav-link text-text-muted hover:text-text text-sm"
        >
          {{ t("home.projectPrevious") }}
        </a>
        <a
          v-if="nextSlug"
          :href="projects.show(nextSlug).url"
          class="nav-link text-text-muted hover:text-text text-sm"
        >
          {{ t("home.projectNext") }}
        </a>
      </nav>
    </section>
  </PublicLayout>
</template>

<script setup lang="ts">
import { Head, usePage } from "@inertiajs/vue3"
import { ExternalLink, Github } from "lucide-vue-next"
import { computed } from "vue"
import { useI18n } from "vue-i18n"

import SkillIcon from "@/components/SkillIcon.vue"
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import PublicLayout from "@/layouts/PublicLayout.vue"
import { splitParagraphs } from "@/lib/home"
import { projects } from "@/routes"
import type { ProjectShow } from "@/types/serializers/ProjectShow"

const props = defineProps<ProjectShow>()
const page = usePage()
const { t } = useI18n()

const previousSlug =
  typeof props.previous_slug === "string" ? props.previous_slug : null
const nextSlug = typeof props.next_slug === "string" ? props.next_slug : null

const descriptionParagraphs = computed(() =>
  splitParagraphs(props.project.description ?? ""),
)

const metaDescription = computed(() => {
  const short = props.project.short_description?.trim()
  if (short) return short

  const description = props.project.description?.trim()
  if (!description) return props.project.name

  return description.length > 160
    ? `${description.slice(0, 157)}...`
    : description
})

const canonicalUrl = computed(() => {
  const url = page.url
  if (url.startsWith("http")) return url
  return `${window.location.origin}${url.startsWith("/") ? url : `/${url}`}`
})

const ogImageUrl = computed(() => `${window.location.origin}/og.png`)
</script>
