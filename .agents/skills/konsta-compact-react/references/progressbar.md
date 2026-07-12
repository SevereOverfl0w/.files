# Progressbar React Component

Docs: https://konstaui.com/react/progressbar

## Purpose
In addition to [Preloader](/react/preloader) there is also determinate progressbar to indicate activity.

## Forwarded / Implicit HTML Props
- `Progressbar`: Any remaining props are forwarded to the root `component` element, defaulting to `<span>`.

## Progressbar Props Summary
- `component` (string) — Component's HTML Element Default: `'span'`.
- `progress` (number) — Determinate progress (from 0 to 1) Default: `0`.

### Progressbar `colors` keys
- `trackBgIos` — Tailwind color override. Default: `'bg-black/10 dark:bg-primary/10'`.
- `trackBgMaterial` — Tailwind color override. Default: `'bg-md-light-primary/30 dark:bg-md-dark-primary/30'`.
- `activeBgIos` — Tailwind color override. Default: `'bg-primary'`.
- `activeBgMaterial` — Tailwind color override. Default: `'bg-md-light-primary dark:bg-md-dark-primary'`.

## Example
```tsx
<Block strong inset>
  <div className="mb-2 text-sm">Uploading… 65%</div>
  <Progressbar progress={65} />
</Block>
```
