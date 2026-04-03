# Segmented Control React Component

Docs: https://konstaui.com/react/segmented

## Purpose
Segmented control is a linear set of two or more segments (buttons), each of which functions as a mutually exclusive button. Within the control, all buttons are equal in width. Segmented controls are often used to display different views (switch tabs).

## Forwarded / Implicit HTML Props
- `Segmented`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`. In iOS navbar context it instead renders through `Glass`.
- `SegmentedButton`: Any remaining props are forwarded to the underlying `Button`, whose root `component` defaults to `<button>`.

## Segmented Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `raised` (boolean) — Makes segmented raised Default: `false`.
- `raisedIos` (boolean) — Makes segmented raised in iOS theme Default: `false`.
- `raisedMaterial` (boolean) — Makes segmented raised in Material theme Default: `false`.
- `outline` (boolean) — Makes segmented outline Default: `false`.
- `outlineIos` (boolean) — Makes segmented outline in iOS theme Default: `false`.
- `outlineMaterial` (boolean) — Makes segmented outline in Material theme Default: `false`.
- `strong` (boolean) — Makes segmented strong Default: `false`.
- `strongIos` (boolean) — Makes segmented strong in iOS theme Default: `false`.
- `strongMaterial` (boolean) — Makes segmented strong in Material theme Default: `false`.
- `rounded` (boolean) — Makes segmented rounded Default: `false`.
- `roundedIos` (boolean) — Makes segmented rounded in iOS theme Default: `false`.
- `roundedMaterial` (boolean) — Makes segmented rounded in Material theme Default: `false`.

### Segmented `colors` keys
- `strongBgIos` — Tailwind color override. Default: `'bg-black/5 dark:bg-white/10'`.
- `strongBgMaterial` — Tailwind color override. Default: `'bg-md-light-surface-variant dark:bg-md-dark-surface-variant'`.
- `strongHighlightBgIos` — Tailwind color override. Default: `'bg-white dark:bg-white/75'`.
- `strongHighlightBgMaterial` — Tailwind color override. Default: `'bg-white dark:bg-white/15'`.
- `borderIos` — Tailwind color override. Default: `'border-primary'`.
- `borderMaterial` — Tailwind color override. Default: `'border-md-light-outline dark:border-md-dark-outline'`.
- `divideIos` — Tailwind color override. Default: `'divide-primary'`.
- `divideMaterial` — Tailwind color override. Default: `'divide-md-light-outline dark:divide-md-dark-outline'`.

## SegmentedButton Props Summary
- `component` (string) — Component's HTML Element Default: `'button'`.
- `active` (boolean) — Highlights button as active Default: `false`.

## Example
```tsx
<Segmented strong>
  <SegmentedButton active>Day</SegmentedButton>
  <SegmentedButton>Week</SegmentedButton>
  <SegmentedButton>Month</SegmentedButton>
</Segmented>
```
