import path from 'node:path'
import { fileURLToPath } from 'node:url'
import tailwindcss from '@tailwindcss/vite'
import inertia from '@inertiajs/vite'
import vue from '@vitejs/plugin-vue'
import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'

const dir = fileURLToPath(new URL('.', import.meta.url))

export default defineConfig({
  plugins: [tailwindcss(), RubyPlugin(), inertia(), vue()],
  resolve: {
    alias: {
      '@': path.resolve(dir, 'app/frontend'),
    },
  },
})
