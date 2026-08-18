<script setup lang="ts">
import { computed } from 'vue'
import { Head, Link, useForm, usePage } from '@inertiajs/vue3'
import AuthLayout from '@/layouts/AuthLayout.vue'
import AuthField from '@/components/auth/AuthField.vue'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from '@/components/ui/card'

const props = defineProps<{
  submitUrl: string
  loginUrl: string
  errors?: Record<string, string>
}>()

const page = usePage()
const flash = computed(() => page.flash as { alert?: string; notice?: string } | undefined)

const form = useForm({
  admin: {
    email: '',
  },
})

function submit() {
  form.post(props.submitUrl)
}
</script>

<template>
  <AuthLayout>
    <Head :title="$t('auth.passwords.new.documentTitle')" />
    <Card class="bg-surface py-6 ring-line">
      <CardHeader class="px-6">
        <CardTitle class="text-2xl tracking-tight text-ink">
          {{ $t('auth.passwords.new.title') }}
        </CardTitle>
        <CardDescription class="text-muted">
          {{ $t('auth.passwords.new.subtitle') }}
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
            :error="form.errors.email || errors?.email"
          />
          <Button type="submit" class="h-10 w-full" :disabled="form.processing">
            {{ $t('auth.passwords.new.submit') }}
          </Button>
        </form>
      </CardContent>
      <CardFooter class="justify-center border-t-0 bg-transparent px-6">
        <Link
          :href="loginUrl"
          class="text-sm text-muted no-underline transition-colors hover-fine:text-accent"
        >
          {{ $t('auth.passwords.backToLogin') }}
        </Link>
      </CardFooter>
    </Card>
  </AuthLayout>
</template>
