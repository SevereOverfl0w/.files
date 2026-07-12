# Block React Component

Docs: https://konstaui.com/react/block

## Purpose
Block React component represents Content Block element designed (mostly) to add extra formatting and required spacing for text content.

## Forwarded / Implicit HTML Props
- `Block`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.
- `BlockTitle`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.
- `BlockHeader`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.
- `BlockFooter`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.

## Block Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `strong` (boolean) — Adds extra highlighting and padding block content. Overwrites `strongIos` and `strongMaterial` props Default: `undefined`.
- `strongIos` (boolean) — Adds extra highlighting and padding block content in iOS theme Default: `false`.
- `strongMaterial` (boolean) — Adds extra highlighting and padding block content in Material theme Default: `false`.
- `inset` (boolean) — Makes block inset. Overwrites `insetIos` and `insetMaterial` props Default: `undefined`.
- `insetIos` (boolean) — Makes block inset in iOS theme Default: `false`.
- `insetMaterial` (boolean) — Makes block inset in Material theme Default: `false`.
- `outline` (boolean) — Makes block outline. Overwrites `outlineIos` and `outlineMaterial` props Default: `undefined`.
- `outlineIos` (boolean) — Makes block outline in iOS theme Default: `false`.
- `outlineMaterial` (boolean) — Makes block outline in Material theme Default: `false`.
- `nested` (boolean) — Removes hairlines and margins, useful for case nesting block within other blocks Default: `false`.

### Block `colors` keys
- `outlineIos` — Tailwind color override. Default: `'border-black/20 dark:border-white/15'`.
- `outlineMaterial` — Tailwind color override. Default: `'border-md-light-outline border-md-dark-outline'`.
- `strongBgIos` — Tailwind color override. Default: ``bg-ios-light-surface-1 dark:bg-ios-dark-surface-1'`.
- `strongBgMaterial` — Tailwind color override. Default: `'bg-md-light-surface-1 dark:bg-md-dark-surface-1'`.
- `textIos` — Tailwind color override. Default: `'''`.
- `textMaterial` — Tailwind color override. Default: `'text-md-light-on-surface dark:text-md-dark-on-surface'`.

## BlockTitle Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `medium` (boolean) — Medium sized block title Default: `false`.
- `large` (boolean) — Large sized block title Default: `false`.

### BlockTitle `colors` keys
- `textIos` — Tailwind color override. Default: `'text-black/60 dark:text-white/60'`.
- `textMaterial` — Tailwind color override. Default: `'text-md-light-primary dark:text-md-dark-primary'`.
- `mediumTextIos` — Tailwind color override. Default: `'text-black dark:text-white'`.
- `mediumTextMaterial` — Tailwind color override. Default: `'text-md-light-primary dark:text-md-dark-primary'`.
- `largeTextIos` — Tailwind color override. Default: `'text-black dark:text-white'`.
- `largeTextMaterial` — Tailwind color override. Default: `'text-md-light-primary dark:text-md-dark-primary'`.

## BlockHeader Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `inset` (boolean) — Makes block header inset, overwrites `insetIos` and `insetMaterial` Default: `undefined`.
- `insetIos` (boolean) — Makes block header inset in iOS theme Default: `false`.
- `insetMaterial` (boolean) — Makes block header inset in Material theme Default: `false`.

### BlockHeader `colors` keys
- `textIos` — Tailwind color override. Default: `'text-black/60 dark:text-white/60'`.
- `textMaterial` — Tailwind color override. Default: `'text-md-light-on-surface-variant dark:text-md-dark-on-surface-variant'`.

## BlockFooter Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `inset` (boolean) — Makes block footer inset, overwrites `insetIos` and `insetMaterial` Default: `undefined`.
- `insetIos` (boolean) — Makes block footer inset in iOS theme Default: `false`.
- `insetMaterial` (boolean) — Makes block footer inset in Material theme Default: `false`.

### BlockFooter `colors` keys
- `textIos` — Tailwind color override. Default: `'text-black/60 dark:text-white/60'`.
- `textMaterial` — Tailwind color override. Default: `'text-md-light-on-surface-variant dark:text-md-dark-on-surface-variant'`.

## Example
```tsx
<>
  <BlockTitle>Overview</BlockTitle>
  <Block strong inset>
    Konsta blocks are useful for grouped text and spacing.
  </Block>
  <BlockFooter>Updated a moment ago</BlockFooter>
</>
```
