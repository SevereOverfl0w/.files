# Chip React Component

Docs: https://konstaui.com/react/chip

## Purpose
Chip is a compact element for tags, filters, selections, and removable tokens.

## Forwarded / Implicit HTML Props
- `Chip`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.

## Chip Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `media` (React.ReactNode) — Content of the chip media area (e.g. icon)
- `deleteButton` (boolean) — Defines whether the Chip has additional "delete" button or not Default: `false`.
- `outline` (boolean) — Makes chip outline Default: `false`.
- `onDelete` ((e: any) => void) — Event will be triggered on Chip delete button click

### Chip `colors` keys
- `fillTextIos` — Tailwind color override. Default: `'text-current'`.
- `fillTextMaterial` — Tailwind color override. Default: `'text-md-light-on-secondary-container dark:text-md-dark-on-secondary-container'`.
- `fillBgIos` — Tailwind color override. Default: `'bg-black/10 dark:bg-white/10'`.
- `fillBgMaterial` — Tailwind color override. Default: `'bg-md-light-secondary-container dark:bg-md-dark-secondary-container'`.
- `outlineTextIos` — Tailwind color override. Default: `'text-current'`.
- `outlineTextMaterial` — Tailwind color override. Default: `'text-md-light-on-surface dark:text-md-dark-on-surface'`.
- `outlineBorderIos` — Tailwind color override. Default: `'border-black/20 dark:border-white/20'`.
- `outlineBorderMaterial` — Tailwind color override. Default: `'border-md-light-outline dark:border-md-dark-outline'`.

## Example
```tsx
<div className="flex gap-2 flex-wrap">
  <Chip text="Design" />
  <Chip media={<Icon ios={<StarIcon />} material={<StarIcon />} />}>
    Favorite
  </Chip>
</div>
```
