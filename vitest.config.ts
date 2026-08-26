import { defineConfig } from "vitest/config"
import vue from "@vitejs/plugin-vue"
import path from "node:path"

export default defineConfig({
  plugins: [vue()],
  test: {
    environment: "happy-dom",
    include: ["app/frontend/**/*.test.ts"],
    coverage: {
      enabled: true,
      provider: "v8",
      include: ["app/frontend/lib/**/*.ts", "app/frontend/i18n.ts"],
      exclude: ["**/*.test.ts"],
      thresholds: {
        lines: 100,
        functions: 100,
        branches: 100,
        statements: 100,
      },
    },
  },
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "app/frontend"),
    },
  },
})
