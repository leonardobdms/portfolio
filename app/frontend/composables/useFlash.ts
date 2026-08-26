import { router } from "@inertiajs/vue3"
import { toast } from "vue-sonner"

import type { FlashData } from "@/types"

function hasFlash(flash: FlashData) {
  return Boolean(flash.notice || flash.alert)
}

let lastMessage = ""
let lastShownAt = 0

export function showFlash(flash: FlashData) {
  if (!hasFlash(flash)) return

  const message = flash.alert ?? flash.notice ?? ""
  const now = Date.now()

  if (message === lastMessage && now - lastShownAt < 500) return

  lastMessage = message
  lastShownAt = now

  if (flash.alert) toast.error(flash.alert)
  if (flash.notice) toast(flash.notice)
}

let initialized = false

export function initFlashNotifications() {
  if (initialized || typeof window === "undefined") return

  initialized = true

  router.on("flash", (event) => {
    showFlash(event.detail.flash as FlashData)
  })
}
