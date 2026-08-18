import { computed } from 'vue'
import { usePage } from '@inertiajs/vue3'
import type { PageProps } from '../types'

export function usePortfolio() {
  const page = usePage<PageProps>()
  return computed(() => {
    const payload = page.props.portfolio
    if (!payload) {
      throw new Error('Portfolio payload is missing from the page.')
    }
    return payload
  })
}
