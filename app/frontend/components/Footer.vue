<script setup lang="ts">
import { usePortfolio } from '@/composables/usePortfolio'
import { Button } from '@/components/ui/button'
import { Separator } from '@/components/ui/separator'

const portfolio = usePortfolio()
</script>

<template>
  <footer>
    <Separator class="bg-line" />
    <div class="shell flex flex-col gap-2 py-8 sm:flex-row sm:items-center sm:justify-between">
      <p class="text-sm text-faint">
        © {{ portfolio.profile.copyrightYear }} {{ portfolio.profile.name }}
      </p>
      <Button variant="link" as-child class="h-auto px-0 text-faint">
        <a href="#topo">
          {{ $t('footer.backToTop') }}
        </a>
      </Button>
    </div>
  </footer>
</template>
