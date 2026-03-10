#!/bin/bash

# ── Fix About.tsx — bigger center logo ────────────────────────
sed -i '' 's/width: .90px., height: .90px., filter/width: "160px", height: "160px", filter/g' src/components/sections/About.tsx
sed -i '' 's/width={90}/width={160}/g' src/components/sections/About.tsx
sed -i '' 's/height={90}/height={160}/g' src/components/sections/About.tsx

# ── Fix Navbar.tsx — bigger logo mark + text ──────────────────
sed -i '' 's/width: .36px., height: .36px., filter/width: "48px", height: "48px", filter/g' src/components/layout/Navbar.tsx
sed -i '' 's/width={36}/width={48}/g' src/components/layout/Navbar.tsx
sed -i '' 's/height={36}/height={48}/g' src/components/layout/Navbar.tsx
sed -i '' "s/fontSize: '1.1rem'/fontSize: '1.35rem'/g" src/components/layout/Navbar.tsx

echo "✅ Logo sizes fixed in About + Navbar!"
echo "   Check localhost:3000"
