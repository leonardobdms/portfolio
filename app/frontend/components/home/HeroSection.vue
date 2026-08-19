<script setup lang="ts">
import { MapPin } from "lucide-vue-next"
import { computed } from "vue"
import { useI18n } from "vue-i18n"

import SocialLinks from "@/components/home/SocialLinks.vue"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { Button } from "@/components/ui/button"
import {
  featuredProjects,
  hasContact,
  profileSocials,
  specialtySkills,
} from "@/lib/home"
import type { Profile } from "@/types"

const props = defineProps<{
  profile: Profile
}>()

const { t } = useI18n()

const socials = computed(() => profileSocials(props.profile))
const specialties = computed(() => specialtySkills(props.profile.skills))
const hasFeaturedWork = computed(
  () => featuredProjects(props.profile.projects).length > 0,
)
const showContact = computed(() => hasContact(props.profile))

const initials = computed(() =>
  props.profile.name
    .split(/\s+/)
    .filter(Boolean)
    .slice(0, 2)
    .map((part) => part[0])
    .join("")
    .toUpperCase(),
)
</script>

<template>
  <section
    class="mx-auto grid min-h-[calc(100dvh-4rem)] max-w-7xl items-center gap-12 px-4 pt-16 pb-16 md:px-8 md:pt-20 lg:grid-cols-[minmax(0,1.1fr)_minmax(0,0.9fr)] lg:gap-16"
  >
    <div class="max-w-2xl">
      <p
        v-if="profile.available_for_work"
        class="border-border bg-surface text-text inline-flex items-center gap-2 rounded-full border px-3 py-1 text-sm"
      >
        <span class="bg-success size-1.5 rounded-full" aria-hidden="true" />
        {{ t("home.available") }}
      </p>

      <div v-if="profile.avatar_url" class="mt-6">
        <Avatar class="size-16">
          <AvatarImage :src="profile.avatar_url" :alt="profile.name" />
          <AvatarFallback>{{ initials }}</AvatarFallback>
        </Avatar>
      </div>

      <h1
        class="text-text mt-6 text-4xl font-semibold tracking-tighter md:text-5xl lg:text-6xl"
      >
        {{ profile.name }}
      </h1>

      <p
        v-if="profile.headline"
        class="text-text-muted mt-4 max-w-[40ch] text-lg leading-relaxed md:text-xl"
      >
        {{ profile.headline }}
      </p>

      <p
        v-if="profile.location"
        class="text-text-muted mt-4 flex items-center gap-2 text-sm"
      >
        <MapPin
          :stroke-width="1.5"
          class="size-4 shrink-0"
          aria-hidden="true"
        />
        <span>{{ profile.location }}</span>
      </p>

      <div class="mt-8 flex flex-wrap items-center gap-3">
        <Button v-if="showContact" as="a" href="#contact">
          {{ t("home.cta") }}
        </Button>
        <Button
          v-if="hasFeaturedWork"
          as="a"
          href="#projects"
          variant="outline"
        >
          {{ t("home.viewWork") }}
        </Button>
        <SocialLinks :links="socials" />
      </div>
    </div>

    <ul
      v-if="specialties.length > 0"
      class="hidden flex-col justify-center gap-3 lg:flex"
      aria-hidden="true"
    >
      <li
        v-for="(skill, index) in specialties"
        :key="skill.id"
        class="border-border bg-surface motion-safe:animate-in motion-safe:fade-in motion-safe:slide-in-from-bottom-3 rounded-xl border px-6 py-5"
        :class="[
          index === 1 ? 'lg:ml-10' : '',
          index === 0 ? 'delay-100' : index === 1 ? 'delay-200' : 'delay-300',
        ]"
      >
        <p class="text-text text-3xl font-semibold tracking-tighter">
          {{ skill.name }}
        </p>
        <p class="text-text-muted mt-1 text-sm">{{ skill.category }}</p>
      </li>
    </ul>
  </section>
</template>
