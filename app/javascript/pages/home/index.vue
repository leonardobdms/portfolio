<template>
  <Head title="Welcome" />
  <div class="flex min-h-screen items-center justify-center bg-gray-50">
    <div class="mx-auto max-w-md space-y-6 p-8 text-center">
      <h1 class="text-4xl font-bold text-gray-900">Welcome to Inertia Rails</h1>
      <p class="text-lg text-gray-600">
        Your app is ready. Start building something amazing.
      </p>
      <div class="space-y-2 text-sm text-gray-500">
        <p>Rails {{ rails_version }} &middot; Ruby {{ ruby_version }}</p>
        <p>Inertia Rails {{ inertia_rails_version }}</p>
      </div>
      <div class="pt-4">
        <a
          href="https://inertia-rails.dev"
          class="inline-flex items-center rounded-md bg-gray-900 px-4 py-2 text-sm font-medium text-white hover:bg-gray-800"
          target="_blank"
          rel="noopener noreferrer"
        >
          Documentation
        </a>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { Head } from "@inertiajs/vue3"

defineProps<{
  rails_version: string
  ruby_version: string
  inertia_rails_version: string
}>()
</script>
