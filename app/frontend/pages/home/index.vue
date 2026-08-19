<template>
  <Head :title="profile.name" />

  <div
    id="top"
    class="bg-background text-text min-h-[100dvh] font-sans antialiased"
  >
    <SiteHeader :profile="profile" />

    <main>
      <HeroSection :profile="profile" />
      <SkillsSection
        v-if="profile.skills.length > 0"
        :skills="profile.skills"
      />
      <ExperienceSection
        v-if="profile.experiences.length > 0"
        :experiences="profile.experiences"
      />
      <FeaturedProjectsSection
        v-if="featured.length > 0"
        :projects="featured"
      />
      <AboutSection v-if="profile.bio" :profile="profile" />
      <EducationSection
        v-if="profile.educations.length > 0"
        :educations="profile.educations"
      />
      <ContactSection v-if="showContact" :profile="profile" />
    </main>
  </div>
</template>

<script setup lang="ts">
import { Head } from "@inertiajs/vue3"
import { computed } from "vue"

import AboutSection from "@/components/home/AboutSection.vue"
import ContactSection from "@/components/home/ContactSection.vue"
import EducationSection from "@/components/home/EducationSection.vue"
import ExperienceSection from "@/components/home/ExperienceSection.vue"
import FeaturedProjectsSection from "@/components/home/FeaturedProjectsSection.vue"
import HeroSection from "@/components/home/HeroSection.vue"
import SiteHeader from "@/components/home/SiteHeader.vue"
import SkillsSection from "@/components/home/SkillsSection.vue"
import { featuredProjects, hasContact } from "@/lib/home"
import type { HomeIndex } from "@/types/serializers/HomeIndex"

const props = defineProps<HomeIndex>()

const featured = computed(() => featuredProjects(props.profile.projects))
const showContact = computed(() => hasContact(props.profile))
</script>
