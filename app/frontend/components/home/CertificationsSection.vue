<script setup lang="ts">
import { ExternalLink } from "lucide-vue-next"
import { useI18n } from "vue-i18n"

import HomeSection from "@/components/home/HomeSection.vue"
import Reveal from "@/components/home/Reveal.vue"
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import { formatMonthYear } from "@/lib/home"
import type { Certification } from "@/types"

const props = defineProps<{
  certifications: Certification[]
}>()

const { t, locale } = useI18n()

function isExpired(certification: Certification): boolean {
  if (!certification.expires_at) return false
  return new Date(certification.expires_at) < new Date()
}

function issuedLabel(certification: Certification): string {
  if (!certification.issued_at) return ""
  return formatMonthYear(certification.issued_at, locale.value)
}
</script>

<template>
  <HomeSection id="certifications" :title="t('home.certificationsTitle')">
    <div class="grid gap-4 md:grid-cols-2">
      <Reveal
        v-for="certification in props.certifications"
        :key="certification.id"
        class="border-border bg-surface hover:border-primary/40 rounded-xl border p-6 transition-colors"
      >
        <div class="flex items-start justify-between gap-3">
          <div>
            <h3 class="text-text text-lg font-medium">
              {{ certification.name }}
            </h3>
            <p class="text-text-muted mt-1 text-sm">
              {{ certification.issuer }}
            </p>
          </div>
          <Badge
            v-if="isExpired(certification)"
            variant="outline"
            class="text-warning border-warning/40 shrink-0"
          >
            {{ t("home.certificationExpired") }}
          </Badge>
        </div>
        <p class="text-text-muted mt-4 font-mono text-sm">
          {{
            issuedLabel(certification)
              ? t("home.certificationIssued", {
                  date: issuedLabel(certification),
                })
              : null
          }}
        </p>
        <p
          v-if="certification.credential_id"
          class="text-text-muted mt-2 font-mono text-sm"
        >
          {{ t("home.certificationId", { id: certification.credential_id }) }}
        </p>
        <Button
          v-if="certification.credential_url"
          as="a"
          variant="outline"
          size="sm"
          class="mt-4"
          :href="certification.credential_url"
          target="_blank"
          rel="noopener noreferrer"
        >
          <ExternalLink aria-hidden="true" :stroke-width="1.5" />
          {{ t("home.certificationView") }}
        </Button>
      </Reveal>
    </div>
  </HomeSection>
</template>
