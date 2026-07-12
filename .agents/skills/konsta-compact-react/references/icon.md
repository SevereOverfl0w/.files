# Icon React Component

Docs: https://konstaui.com/react/icon

## Purpose
Icon renders icon content with Konsta-friendly sizing and theme-aware alignment.

## Forwarded / Implicit HTML Props
- `Icon`: Any remaining props are forwarded to the root `component` element, defaulting to `<i>`.

## Icon Props Summary
- `component` (string) — Component's HTML Element Default: `'i'`.
- `badge` (string | number | React.ReactNode) — Icon badge
- `ios` (React.ReactNode) — Icon to render in "ios" theme
- `material` (React.ReactNode) — Icon to render in "material" theme
- `badgeColors` (object) — Badge colors. Object with Tailwind CSS colors classes

## Example
```tsx
<Button inline clear>
  <Icon ios={<ChevronLeft />} material={<ChevronLeft />} />
  Back
</Button>
```
