import type { VariantProps } from 'class-variance-authority'
import { cva } from 'class-variance-authority'

export { default as Heading } from './Heading.vue'

export const headingVariants = cva('tracking-tight text-ink', {
  variants: {
    variant: {
      hero: 'max-w-5xl text-balance text-4xl font-medium leading-[1.1] sm:text-5xl md:text-6xl',
      section: 'reveal text-2xl font-medium',
      lead: 'text-balance text-3xl leading-[1.15] sm:text-4xl md:text-5xl',
      item: 'text-xl',
    },
  },
  defaultVariants: {
    variant: 'section',
  },
})

export type HeadingVariants = VariantProps<typeof headingVariants>
