<script setup lang="ts">
import { computed } from 'vue'
import { Head, Link, useForm, usePage } from '@inertiajs/vue3'
import AuthLayout from '@/layouts/AuthLayout.vue'
import AuthField from '@/components/auth/AuthField.vue'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '@/components/ui/card'

const props = defineProps<{
  submitUrl: string
  forgotPasswordUrl: string
  homeUrl: string
}>()

const page = usePage()
const flash = computed(() => page.flash as { alert?: string; notice?: string } | undefined)

const form = useForm({
  admin: {
    email: '',
    password: '',
    remember_me: false,
  },
})

function submit() {
  form.post(props.submitUrl)
}
</script>

<template>
  <AuthLayout>
    <Head :title="$t('auth.sessions.documentTitle')" />
    <Card class="bg-surface py-6 ring-line">
      <CardHeader class="px-6">
        <CardTitle class="text-2xl tracking-tight text-ink">
          {{ $t('auth.sessions.title') }}
        </CardTitle>
        <CardDescription class="text-muted">
          {{ $t('auth.sessions.subtitle') }}
        </CardDescription>
      </CardHeader>
      <CardContent class="px-6">
        <p v-if="flash?.alert" class="mb-4 text-sm text-destructive" role="alert">
          {{ flash.alert }}
        </p>
        <p v-if="flash?.notice" class="mb-4 text-sm text-accent" role="status">
          {{ flash.notice }}
        </p>
        <form class="grid gap-4" @submit.prevent="submit">
          <AuthField
            id="admin_email"
            v-model="form.admin.email"
            type="email"
            required
            autofocus
            autocomplete="username"
            :label="$t('auth.fields.email')"
            :error="form.errors.email"
          />
          <AuthField
            id="admin_password"
            v-model="form.admin.password"
            type="password"
            required
            autocomplete="current-password"
            :label="$t('auth.fields.password')"
            :error="form.errors.password"
          />
          <label class="flex items-center gap-2 text-sm text-muted">
            <input
              v-model="form.admin.remember_me"
              type="checkbox"
              class="size-4 rounded-sm border-line accent-accent"
            >
            {{ $t('auth.sessions.rememberMe') }}
          </label>
          <Button type="submit" class="h-10 w-full" :disabled="form.processing">
            {{ $t('auth.sessions.submit') }}
          </Button>
        </form>
      </CardContent>
          <CardFooter class="flex-col items-stretch gap-2 border-t-0 bg-transparent px-6">
        <Link
          :href="forgotPasswordUrl"
          class="text-center text-sm text-muted no-underline transition-colors hover-fine:text-accent"
        >
          {{ $t('auth.sessions.forgotPassword') }}
        </Link>
        <a
          :href="homeUrl"
          class="text-center text-sm text-muted no-underline transition-colors hover-fine:text-accent"
        >
          {{ $t('auth.sessions.backToSite') }}
        </a>
      </CardFooter>
    </Card>
  </AuthLayout>
</template>
