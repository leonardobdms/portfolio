<template>
  <Head :title="profile.name">
    <meta
      head-key="description"
      name="description"
      :content="metaDescription"
    />
    <meta head-key="og:title" property="og:title" :content="profile.name" />
    <meta
      head-key="og:description"
      property="og:description"
      :content="metaDescription"
    />
    <meta head-key="og:type" property="og:type" content="profile" />
    <meta head-key="og:url" property="og:url" :content="canonicalUrl" />
    <meta head-key="og:image" property="og:image" :content="ogImageUrl" />
    <meta
      head-key="twitter:card"
      name="twitter:card"
      content="summary_large_image"
    />
    <meta
      head-key="twitter:title"
      name="twitter:title"
      :content="profile.name"
    />
    <meta
      head-key="twitter:description"
      name="twitter:description"
      :content="metaDescription"
    />
    <meta head-key="twitter:image" name="twitter:image" :content="ogImageUrl" />
    <link head-key="canonical" rel="canonical" :href="canonicalUrl" />
  </Head>

  <PublicLayout :profile="profile" :active-section="activeSection">
    <HeroSection :profile="profile" />
    <SkillsSection v-if="profile.skills.length > 0" :skills="profile.skills" />
    <ExperienceSection
      v-if="profile.experiences.length > 0"
      :experiences="profile.experiences"
    />
    <FeaturedProjectsSection v-if="featured.length > 0" :projects="featured" />
    <AboutSection v-if="profile.bio" :profile="profile" />
    <CertificationsSection
      v-if="profile.certifications.length > 0"
      :certifications="profile.certifications"
    />
    <EducationSection
      v-if="profile.educations.length > 0"
      :educations="profile.educations"
    />
    <ContactSection v-if="showContact" :profile="profile" />
  </PublicLayout>
</template>

<script setup lang="ts">
import { Head, usePage } from "@inertiajs/vue3"
import { computed } from "vue"

import AboutSection from "@/components/home/AboutSection.vue"
import CertificationsSection from "@/components/home/CertificationsSection.vue"
import ContactSection from "@/components/home/ContactSection.vue"
import EducationSection from "@/components/home/EducationSection.vue"
import ExperienceSection from "@/components/home/ExperienceSection.vue"
import FeaturedProjectsSection from "@/components/home/FeaturedProjectsSection.vue"
import HeroSection from "@/components/home/HeroSection.vue"
import SkillsSection from "@/components/home/SkillsSection.vue"
import { useActiveSection } from "@/composables/useActiveSection"
import PublicLayout from "@/layouts/PublicLayout.vue"
import { featuredProjects, hasContact } from "@/lib/home"
import type { HomeIndex } from "@/types/serializers/HomeIndex"

const props = defineProps<HomeIndex>()
const page = usePage()

const featured = computed(() => featuredProjects(props.profile.projects))
const showContact = computed(() => hasContact(props.profile))
const { activeSection } = useActiveSection()

const metaDescription = computed(() => {
  const headline = props.profile.headline?.trim()
  if (headline) return headline

  const bio = props.profile.bio?.trim()
  if (!bio) return props.profile.name

  return bio.length > 160 ? `${bio.slice(0, 157)}...` : bio
})

const canonicalUrl = computed(() => {
  const url = page.url
  if (url.startsWith("http")) return url
  return `${window.location.origin}${url.startsWith("/") ? url : `/${url}`}`
})

const ogImageUrl = computed(() => {
  if (props.profile.avatar_url) return props.profile.avatar_url
  return `${window.location.origin}/og.png`
})
</script>
