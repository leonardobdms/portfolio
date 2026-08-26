import { onMounted, onUnmounted, ref } from "vue"

import { type NavKey } from "@/lib/home"

const SECTION_IDS: NavKey[] = [
  "skills",
  "experience",
  "projects",
  "about",
  "certifications",
  "contact",
]

export function useActiveSection() {
  const activeSection = ref<NavKey | null>(null)

  function updateActiveSection() {
    const offset = 120
    let current: NavKey | null = null

    for (const id of SECTION_IDS) {
      const element = document.getElementById(id)
      if (!element) continue

      const top = element.getBoundingClientRect().top
      if (top - offset <= 0) {
        current = id
      }
    }

    activeSection.value = current
  }

  onMounted(() => {
    updateActiveSection()
    window.addEventListener("scroll", updateActiveSection, { passive: true })
  })

  onUnmounted(() => {
    window.removeEventListener("scroll", updateActiveSection)
  })

  return { activeSection }
}
