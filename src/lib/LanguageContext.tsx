'use client'

import { createContext, useContext, useState, ReactNode } from 'react'

type Lang = 'en' | 'fr'

interface LangCtx {
  lang: Lang
  setLang: (l: Lang) => void
  t: (en: string, fr: string) => string
}

const LanguageContext = createContext<LangCtx>({
  lang: 'en',
  setLang: () => {},
  t: (en) => en,
})

export function LanguageProvider({ children }: { children: ReactNode }) {
  const [lang, setLang] = useState<Lang>('en')
  const t = (en: string, fr: string) => lang === 'fr' ? fr : en
  return (
    <LanguageContext.Provider value={{ lang, setLang, t }}>
      {children}
    </LanguageContext.Provider>
  )
}

export function useLang() {
  return useContext(LanguageContext)
}
