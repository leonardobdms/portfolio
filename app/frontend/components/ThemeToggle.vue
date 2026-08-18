<script setup lang="ts">
import { Moon, Sun } from 'lucide-vue-next'
import { useTheme } from '@/composables/useTheme'
import { Button } from '@/components/ui/button'

const { theme, toggleTheme } = useTheme()
</script>

<template>
  <Button
    type="button"
    variant="ghost"
    size="icon"
    class="size-8 rounded-full text-muted hover-fine:bg-accent-soft hover-fine:text-ink"
    :aria-label="theme === 'dark' ? $t('theme.activateLight') : $t('theme.activateDark')"
    :title="theme === 'dark' ? $t('theme.light') : $t('theme.dark')"
    @click="toggleTheme"
  >
    <Sun v-if="theme === 'dark'" :stroke-width="1.5" aria-hidden="true" />
    <Moon v-else :stroke-width="1.5" aria-hidden="true" />
  </Button>
</template>
