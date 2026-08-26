<template>
  <Head :title="t('auth.title')" />

  <div
    class="bg-background text-text grid min-h-[100dvh] grid-cols-1 md:grid-cols-2"
  >
    <div
      class="relative h-48 w-full overflow-hidden md:h-auto md:min-h-[100dvh]"
    >
      <img
        :src="loginVisual"
        :alt="t('auth.login_visual_alt')"
        class="absolute inset-0 h-full w-full object-cover"
        width="1024"
        height="1365"
      />
    </div>

    <div class="flex w-full items-center px-4 py-8 md:px-16 md:py-16">
      <div class="w-full max-w-md">
        <div class="mb-8 flex justify-end">
          <LocaleSwitcher />
        </div>

        <h1
          class="text-text text-4xl font-semibold tracking-tighter md:text-5xl"
        >
          {{ t("auth.heading") }}
        </h1>
        <p class="text-text-muted mt-3 max-w-[65ch] text-base leading-relaxed">
          {{ t("auth.subtitle") }}
        </p>

        <form class="mt-8 flex flex-col gap-5" @submit.prevent="submit">
          <div class="flex flex-col gap-2">
            <label class="text-text text-sm font-medium" for="admin_email">
              {{ t("auth.email") }}
            </label>
            <input
              id="admin_email"
              v-model="form.admin.email"
              class="border-border bg-surface text-text focus-visible:ring-primary focus-visible:ring-offset-background w-full rounded-xl border px-3 py-2.5 focus-visible:ring-2 focus-visible:ring-offset-2 focus-visible:outline-none"
              type="email"
              name="admin[email]"
              autocomplete="username"
              required
              :disabled="form.processing"
            />
          </div>

          <div class="flex flex-col gap-2">
            <label class="text-text text-sm font-medium" for="admin_password">
              {{ t("auth.password") }}
            </label>
            <input
              id="admin_password"
              v-model="form.admin.password"
              class="border-border bg-surface text-text focus-visible:ring-primary focus-visible:ring-offset-background w-full rounded-xl border px-3 py-2.5 focus-visible:ring-2 focus-visible:ring-offset-2 focus-visible:outline-none"
              type="password"
              name="admin[password]"
              autocomplete="current-password"
              required
              :disabled="form.processing"
            />
          </div>

          <div class="flex items-center gap-2">
            <input
              id="admin_remember_me"
              v-model="form.admin.remember_me"
              class="border-border bg-surface text-primary focus-visible:ring-primary rounded"
              type="checkbox"
              name="admin[remember_me]"
              :disabled="form.processing"
            />
            <label class="text-text text-sm" for="admin_remember_me">
              {{ t("auth.remember_me") }}
            </label>
          </div>

          <button
            class="bg-primary text-text hover:bg-primary-dark w-full rounded-xl px-4 py-3 text-sm font-medium transition-transform disabled:opacity-60 motion-safe:active:scale-[0.98]"
            type="submit"
            :disabled="form.processing"
          >
            {{ form.processing ? t("auth.submitting") : t("auth.submit") }}
          </button>
        </form>

        <p class="text-text-muted mt-8 text-sm">
          <Link class="text-text underline-offset-4 hover:underline" href="/">
            {{ t("auth.back_to_site") }}
          </Link>
        </p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { Head, Link, useForm } from "@inertiajs/vue3"
import { useI18n } from "vue-i18n"

import LocaleSwitcher from "@/components/LocaleSwitcher.vue"

import loginVisual from "../../../assets/images/admin-login.jpg"

const props = defineProps<{
  email?: string | null
  session_url: string
}>()

const { t } = useI18n()

const form = useForm({
  admin: {
    email: props.email ?? "",
    password: "",
    remember_me: false,
  },
})

function submit() {
  form.post(props.session_url)
}
</script>
