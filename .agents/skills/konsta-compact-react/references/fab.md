# Floating Action Button React Component

Docs: https://konstaui.com/react/fab

## Purpose
Floating action buttons (FABs) are used for a promoted action. They are distinguished by a circled icon floating above the UI and have motion behaviors that include morphing, launching, and a transferring anchor point.

## Forwarded / Implicit HTML Props
- `Fab`: Any remaining props are forwarded to the root element rendered by `Glass`, defaulting to `<a>`.

## Fab Props Summary
- `component` (string) — Component's HTML Element Default: `'a'`.
- `href` (string) — Fab's link `href` attribute
- `text` (string | React.ReactNode) — Button text (content)
- `textPosition` ('after' | 'before') — Text position, can be `after` icon or `before` icon Default: `'after'`.
- `icon` (React.ReactNode) — Fab's icon

### Fab `colors` keys
- `bgIos` — Tailwind color override. Default: `'bg-primary dark:bg-ios-primary-shade/50'`.
- `bgMaterial` — Tailwind color override. Default: `'bg-md-light-primary-container dark:bg-md-dark-primary-container'`.
- `activeBgIos` — Tailwind color override. Default: `''`.
- `activeBgMaterial` — Tailwind color override. Default: `''`.
- `textIos` — Tailwind color override. Default: `'text-white'`.
- `textMaterial` — Tailwind color override. Default: `'text-md-light-on-primary-container dark:text-md-dark-on-primary-container'`.
- `touchRipple` — Tailwind color override. Default: `'touch-ripple-primary dark:touch-ripple-white'`.

## Example
```tsx
<Fab
  href="#"
  text="Compose"
  icon={<Icon ios={<PlusIcon />} material={<PlusIcon />} />}
/>
```
