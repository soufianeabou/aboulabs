#!/bin/bash

# Patch the logo icon area in Products.tsx
# Change 64px container → 88px, and image 44px → 64px

sed -i '' 's/width: .64px., height: .64px.,/width: "88px", height: "88px",/g' src/components/sections/Products.tsx
sed -i '' 's/width={44}/width={64}/g' src/components/sections/Products.tsx
sed -i '' 's/height={44}/height={64}/g' src/components/sections/Products.tsx
sed -i '' 's/padding: .10px.,/padding: "14px",/g' src/components/sections/Products.tsx

echo "✅ Logo size updated — check localhost:3000"
