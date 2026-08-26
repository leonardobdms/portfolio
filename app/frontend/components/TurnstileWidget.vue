<script setup lang="ts">
import { onMounted, onUnmounted, ref } from "vue"

type TurnstileTheme = "light" | "dark" | "auto"

type TurnstileRenderOptions = {
  sitekey: string
  theme?: TurnstileTheme
  callback?: (token: string) => void
  "error-callback"?: () => void
  "expired-callback"?: () => void
}

type TurnstileApi = {
  render: (container: HTMLElement, options: TurnstileRenderOptions) => string
  remove: (widgetId: string) => void
  reset: (widgetId: string) => void
}

declare global {
  interface Window {
    turnstile?: TurnstileApi
    onTurnstileLoad?: () => void
  }
}

const props = defineProps<{
  siteKey: string
  theme?: TurnstileTheme
}>()

const emit = defineEmits<{
  verify: [token: string]
  error: []
  expire: []
}>()

const containerRef = ref<HTMLElement | null>(null)
let widgetId: string | undefined
let scriptEl: HTMLScriptElement | undefined

function renderWidget() {
  if (!containerRef.value || !window.turnstile) return

  widgetId = window.turnstile.render(containerRef.value, {
    sitekey: props.siteKey,
    theme: props.theme ?? "auto",
    callback: (token) => emit("verify", token),
    "error-callback": () => emit("error"),
    "expired-callback": () => emit("expire"),
  })
}

function loadTurnstile() {
  if (window.turnstile) {
    renderWidget()
    return
  }

  window.onTurnstileLoad = () => {
    renderWidget()
    window.onTurnstileLoad = undefined
  }

  scriptEl = document.createElement("script")
  scriptEl.src =
    "https://challenges.cloudflare.com/turnstile/v0/api.js?render=explicit&onload=onTurnstileLoad"
  scriptEl.async = true
  scriptEl.defer = true
  document.head.appendChild(scriptEl)
}

// Tokens are single-use, so the widget must issue a new challenge after each submit.
function reset() {
  if (widgetId && window.turnstile) {
    window.turnstile.reset(widgetId)
  }
}

onMounted(() => {
  loadTurnstile()
})

onUnmounted(() => {
  if (widgetId && window.turnstile) {
    window.turnstile.remove(widgetId)
  }

  if (scriptEl) {
    scriptEl.remove()
  }
})

defineExpose({ reset })
</script>

<template>
  <div ref="containerRef" />
</template>
