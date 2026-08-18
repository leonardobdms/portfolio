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
  resetPasswordToken: string
  errors?: Record<string, string>
}>()

const page = usePage()
const flash = computed(() => page.flash as { alert?: string; notice?: string } | undefined)

const form = useForm({
  admin: {
    reset_password_token: props.resetPasswordToken,
    password: '',
    password_confirmation: '',
  },
})

function submit() {
  form.put(props.submitUrl)
}
</script>

<template>
  <AuthLayout>
    <Head :title="$t('auth.passwords.edit.documentTitle')" />
    <Card class="bg-surface py-6 ring-line">
      <CardHeader class="px-6">
        <CardTitle class="text-2xl tracking-tight text-ink">
          {{ $t('auth.passwords.edit.title') }}
        </CardTitle>
        <CardDescription class="text-muted">
          {{ $t('auth.passwords.edit.subtitle') }}
        </CardDescription>
      </CardHeader>
      <CardContent class="px-6">
        <p v-if="flash?.alert" class="mb-4 text-sm text-destructive" role="alert">
          {{ flash.alert }}
        </p>
        <form class="grid gap-4" @submit.prevent="submit">
          <AuthField
            id="admin_password"
            v-model="form.admin.password"
            type="password"
            required
            autofocus
            autocomplete="new-password"
            :label="$t('auth.passwords.edit.newPassword')"
            :error="form.errors.password || errors?.password"
          />
          <AuthField
            id="admin_password_confirmation"
            v-model="form.admin.password_confirmation"
            type="password"
            required
            autocomplete="new-password"
            :label="$t('auth.fields.passwordConfirmation')"
            :error="form.errors.password_confirmation || errors?.password_confirmation"
          />
          <Button type="submit" class="h-10 w-full" :disabled="form.processing">
            {{ $t('auth.passwords.edit.submit') }}
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
