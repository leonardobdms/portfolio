import { onMounted, onUnmounted, ref, watch } from 'vue'
import { NAV_ITEMS } from '@/types'

export function useNavSpy() {
  const scrolled = ref(false)
  const activeHref = ref<string | null>(null)

  let heroObserver: IntersectionObserver | undefined
  let spyObserver: IntersectionObserver | undefined

  watch(scrolled, (isScrolled) => {
    if (!isScrolled) {
      activeHref.value = null
    }
  })

  onMounted(() => {
    const hash = window.location.hash
    if (NAV_ITEMS.some((item) => item.href === hash)) {
      activeHref.value = hash
    }

    const sentinel = document.getElementById('nav-sentinel')
    heroObserver = new IntersectionObserver(
      ([entry]) => {
        scrolled.value = !entry?.isIntersecting
      },
      { threshold: 0 },
    )
    if (sentinel) {
      heroObserver.observe(sentinel)
    }

    const sections = NAV_ITEMS.map((item) => document.getElementById(item.href.slice(1))).filter(
      (element): element is HTMLElement => element !== null,
    )

    spyObserver = new IntersectionObserver(
      (entries) => {
        if (!scrolled.value) {
          return
        }

        const visible = entries
          .filter((entry) => entry.isIntersecting)
          .sort((a, b) => b.intersectionRatio - a.intersectionRatio)
        const id = visible[0]?.target.id
        if (id) {
          activeHref.value = `#${id}`
        }
      },
      {
        rootMargin: '-28% 0px -58% 0px',
        threshold: [0, 0.15, 0.35, 0.6, 1],
      },
    )

    for (const section of sections) {
      spyObserver.observe(section)
    }
  })

  onUnmounted(() => {
    heroObserver?.disconnect()
    spyObserver?.disconnect()
  })

  function activate(href: string) {
    activeHref.value = href === '#topo' ? null : href
  }

  return { scrolled, activeHref, activate }
}
