# Preloader (Spinner) React Component

Docs: https://konstaui.com/react/preloader

## Purpose
Preloader displays indeterminate loading feedback with native-looking iOS and Material styling.

## Forwarded / Implicit HTML Props
- `Preloader`: Any remaining props are forwarded to the root `component` element, defaulting to `<span>`.

## Preloader Props Summary
- `component` (string) — Component's HTML Element Default: `'span'`.

### Preloader `colors` keys
- `iconIos` — Tailwind color override. Default: `'text-primary'`.
- `iconMaterial` — Tailwind color override. Default: `'text-md-light-primary dark:text-md-dark-primary'`.

## Example
```tsx
<div className="flex items-center gap-3">
  <Preloader />
  <span>Loading data…</span>
</div>
```
