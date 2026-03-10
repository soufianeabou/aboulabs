'use client'
import { motion } from 'framer-motion'
import { ReactNode } from 'react'

interface Props {
  children: ReactNode
  delay?: number
  className?: string
  direction?: 'up' | 'left' | 'right'
}

export default function RevealWrapper({
  children,
  delay = 0,
  className = '',
  direction = 'up',
}: Props) {
  const variants = {
    up:    { hidden: { opacity: 0, y: 28 },   visible: { opacity: 1, y: 0 } },
    left:  { hidden: { opacity: 0, x: -28 },  visible: { opacity: 1, x: 0 } },
    right: { hidden: { opacity: 0, x: 28 },   visible: { opacity: 1, x: 0 } },
  }

  return (
    <motion.div
      className={className}
      initial="hidden"
      whileInView="visible"
      viewport={{ once: true, margin: '-40px' }}
      transition={{
        duration: 0.7,
        delay,
        ease: [0.23, 1, 0.32, 1],
      }}
      variants={variants[direction]}
    >
      {children}
    </motion.div>
  )
}