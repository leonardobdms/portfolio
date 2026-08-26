<script setup lang="ts">
import { useForm, usePage } from "@inertiajs/vue3"
import { Mail } from "lucide-vue-next"
import { computed, ref } from "vue"
import { useI18n } from "vue-i18n"

import SocialIcon from "@/components/SocialIcon.vue"
import TurnstileWidget from "@/components/TurnstileWidget.vue"
import SocialLinks from "@/components/home/SocialLinks.vue"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Textarea } from "@/components/ui/textarea"
import { profileSocials, whatsappHref } from "@/lib/home"
import { contacts } from "@/routes"
import type { Profile } from "@/types"
import { toast } from "vue-sonner"

const props = defineProps<{
  profile: Profile
}>()

const { t } = useI18n()
const page = usePage()
const socials = computed(() => profileSocials(props.profile))

const contactUrl = contacts.create().url
const turnstileSiteKey = computed(
  () => page.props.turnstile_site_key as string | null | undefined,
)
const turnstileTheme = computed(() =>
  page.props.theme === "light" ? "light" : "dark",
)
const turnstileWidget = ref<InstanceType<typeof TurnstileWidget> | null>(null)
const turnstileToken = ref("")
const turnstileRequired = computed(() => Boolean(turnstileSiteKey.value))
const canSubmit = computed(
  () => !turnstileRequired.value || turnstileToken.value.length > 0,
)

const form = useForm({
  name: "",
  email: "",
  subject: "",
  message: "",
  website: "",
})

function fieldError(error: string | string[] | undefined) {
  if (!error) return undefined
  return Array.isArray(error) ? error[0] : error
}

const captchaError = computed(() =>
  fieldError(
    (form.errors as Record<string, string | string[] | undefined>).captcha,
  ),
)

function onTurnstileVerify(token: string) {
  turnstileToken.value = token
}

function onTurnstileReset() {
  turnstileToken.value = ""
}

function onSubmitSuccess() {
  onTurnstileReset()
  turnstileWidget.value?.reset()
}

function submit() {
  form
    .transform((data) => ({
      ...data,
      ...(turnstileRequired.value
        ? { "cf-turnstile-response": turnstileToken.value }
        : {}),
    }))
    .post(contactUrl, {
      preserveScroll: true,
      onSuccess: () => {
        form.reset()
        onSubmitSuccess()
      },
      onHttpException: (response) => {
        if (response.status === 429) {
          toast.error(t("home.contactForm.rateLimited"))
        }
      },
    })
}
</script>

<template>
  <section
    id="contact"
    class="mx-auto max-w-7xl scroll-mt-24 px-4 py-16 md:px-8 md:py-24"
  >
    <div
      class="border-border bg-surface flex flex-col gap-8 rounded-xl border px-6 py-12 md:px-12 md:py-16"
    >
      <h2
        class="text-text text-3xl font-semibold tracking-tight text-balance md:text-5xl"
      >
        {{ t("home.contactTitle") }}
      </h2>
      <p
        class="text-text-muted max-w-[65ch] text-base leading-relaxed text-pretty md:text-lg"
      >
        {{
          profile.available_for_work
            ? t("home.contactBodyAvailable")
            : t("home.contactBody")
        }}
      </p>

      <form
        class="grid gap-4 md:grid-cols-2"
        @submit.prevent="submit"
      >
        <input
          v-model="form.website"
          type="text"
          name="website"
          class="hidden"
          tabindex="-1"
          autocomplete="off"
          aria-hidden="true"
        />

        <div class="flex flex-col gap-2">
          <Label for="contact-name">{{ t("home.contactForm.name") }}</Label>
          <Input
            id="contact-name"
            v-model="form.name"
            name="name"
            required
            autocomplete="name"
            :disabled="form.processing"
            :aria-invalid="form.errors.name ? true : undefined"
            :aria-describedby="form.errors.name ? 'contact-name-error' : undefined"
          />
          <p
            v-if="form.errors.name"
            id="contact-name-error"
            class="text-danger text-sm"
          >
            {{ fieldError(form.errors.name) }}
          </p>
        </div>

        <div class="flex flex-col gap-2">
          <Label for="contact-email">{{ t("home.contactForm.email") }}</Label>
          <Input
            id="contact-email"
            v-model="form.email"
            name="email"
            type="email"
            required
            autocomplete="email"
            :disabled="form.processing"
            :aria-invalid="form.errors.email ? true : undefined"
            :aria-describedby="form.errors.email ? 'contact-email-error' : undefined"
          />
          <p
            v-if="form.errors.email"
            id="contact-email-error"
            class="text-danger text-sm"
          >
            {{ fieldError(form.errors.email) }}
          </p>
        </div>

        <div class="flex flex-col gap-2 md:col-span-2">
          <Label for="contact-subject">{{
            t("home.contactForm.subject")
          }}</Label>
          <Input
            id="contact-subject"
            v-model="form.subject"
            name="subject"
            required
            :disabled="form.processing"
            :aria-invalid="form.errors.subject ? true : undefined"
            :aria-describedby="
              form.errors.subject ? 'contact-subject-error' : undefined
            "
          />
          <p
            v-if="form.errors.subject"
            id="contact-subject-error"
            class="text-danger text-sm"
          >
            {{ fieldError(form.errors.subject) }}
          </p>
        </div>

        <div class="flex flex-col gap-2 md:col-span-2">
          <Label for="contact-message">{{
            t("home.contactForm.message")
          }}</Label>
          <Textarea
            id="contact-message"
            v-model="form.message"
            name="message"
            required
            :disabled="form.processing"
            :aria-invalid="form.errors.message ? true : undefined"
            :aria-describedby="
              form.errors.message ? 'contact-message-error' : undefined
            "
          />
          <p
            v-if="form.errors.message"
            id="contact-message-error"
            class="text-danger text-sm"
          >
            {{ fieldError(form.errors.message) }}
          </p>
        </div>

        <div v-if="turnstileSiteKey" class="md:col-span-2">
          <TurnstileWidget
            ref="turnstileWidget"
            :site-key="turnstileSiteKey"
            :theme="turnstileTheme"
            @verify="onTurnstileVerify"
            @error="onTurnstileReset"
            @expire="onTurnstileReset"
          />
          <p
            v-if="captchaError"
            class="text-danger mt-2 text-sm"
            role="alert"
          >
            {{ captchaError }}
          </p>
        </div>

        <div class="md:col-span-2">
          <Button type="submit" :disabled="form.processing || !canSubmit">
            {{
              form.processing
                ? t("home.contactForm.submitting")
                : t("home.contactForm.submit")
            }}
          </Button>
        </div>
      </form>

      <div class="flex flex-wrap items-center gap-3">
        <Button
          v-if="profile.email"
          as="a"
          size="lg"
          :href="`mailto:${profile.email}`"
        >
          <Mail :stroke-width="1.5" aria-hidden="true" />
          {{ profile.email }}
        </Button>
        <Button
          v-if="profile.phone"
          as="a"
          variant="outline"
          size="lg"
          class="group"
          :href="whatsappHref(profile.phone)"
          target="_blank"
          rel="noopener noreferrer"
        >
          <SocialIcon icon="whatsapp" />
          {{ profile.phone }}
        </Button>
        <SocialLinks :links="socials" />
      </div>
    </div>
  </section>
</template>
