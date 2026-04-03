# Card React Component

Docs: https://konstaui.com/react/card

## Purpose
Cards, along with [List View](/react/list), is a one more great way to contain and organize your information. Cards contains unique related data, for example, a photo, text, and link all about a single subject. Cards are typically an entry point to more complex and detailed information.

## Forwarded / Implicit HTML Props
- `Card`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.

## Card Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `header` (string | React.ReactNode) — Content of the Card header
- `footer` (string | React.ReactNode) — Content of the Card footer
- `contentWrap` (boolean) — Wraps card content with extra element with padding Default: `true`.
- `contentWrapPadding` (string) — Content wrap padding (if `contentWrap` enabled) Default: `'p-4'`.
- `outline` (boolean) — Makes card outline. Overwrites `outlineIos` and `outlineMaterial` Default: `undefined`.
- `outlineIos` (boolean) — Makes card outline in iOS theme Default: `false`.
- `outlineMaterial` (boolean) — Makes card outline in Material theme Default: `false`.
- `raised` (boolean) — Makes card raised. Overwrites `raisedIos` and `raisedMaterial` Default: `undefined`.
- `raisedIos` (boolean) — Makes card raised in iOS theme Default: `false`.
- `raisedMaterial` (boolean) — Makes card raised in Material theme Default: `false`.
- `headerDivider` (boolean) — Enabled divider between header and content Default: `false`.
- `footerDivider` (boolean) — Enabled divider between footer and content Default: `false`.
- `Card.headerFontSizeIos` (string) — Tailwind class for the card header font size in iOS theme. Default: `'text-[17px]'`.
- `Card.headerFontSizeMaterial` (string) — Tailwind class for the card header font size in Material theme. Default: `'text-[22px]'`.

### Card `colors` keys
- `textIos` — Tailwind color override. Default: `''`.
- `textMaterial` — Tailwind color override. Default: `'text-md-light-on-surface dark:text-md-dark-on-surface'`.
- `bgIos` — Tailwind color override. Default: `'bg-ios-light-surface-1 dark:bg-ios-dark-surface-1'`.
- `bgMaterial` — Tailwind color override. Default: `'bg-md-light-surface-1 dark:bg-md-dark-surface-1'`.
- `footerTextIos` — Tailwind color override. Default: `'text-black/55 dark:text-white/55'`.
- `footerTextMaterial` — Tailwind color override. Default: `'text-md-light-on-surface-variant dark:text-md-dark-on-surface-variant'`.
- `outlineIos` — Tailwind color override. Default: `'border-black/20 dark:border-white/20'`.
- `outlineMaterial` — Tailwind color override. Default: `'border-md-light-outline dark:border-md-dark-outline'`.

## Example
```tsx
<Card
  header="Profile"
  footer="Last updated just now"
  outline
>
  <div className="space-y-1">
    <div className="font-medium">Alex Johnson</div>
    <div className="text-sm opacity-70">Product Designer</div>
  </div>
</Card>
```
