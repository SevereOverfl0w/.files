# Toolbar React Component

Docs: https://konstaui.com/react/toolbar

## Purpose
Toolbar is a fixed area at the bottom (or top) of a screen that contains navigation elements. Toolbar does not have any parts, just plain links inside

## Forwarded / Implicit HTML Props
- `Toolbar`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.

## Toolbar Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `bgClassName` (string) — Additional class to add on Toolbar's "background" element
- `innerClassName` (string) — Additional class to add on Toolbar's "inner" element
- `outline` (boolean) — Material theme only: Renders outer hairlines (borders) Default: `undefined`.
- `tabbar` (boolean) — Enables tabbar, same as using `<Tabbar>` component Default: `false`.
- `tabbarLabels` (boolean) — Enables tabbar with labels, same as using `<Tabbar labels>` component Default: `false`.
- `tabbarIcons` (boolean) — Enables tabbar with icons, same as using `<Tabbar icons>` component Default: `false`.
- `top` (boolean) — Enables top toolbar, in this case it renders border on shadows on opposite sides Default: `false`.

### Toolbar `colors` keys
- `bgIos` — Tailwind color override. Default: `'bg-gradient-to-t from-ios-light-surface to-transparent dark:from-ios-dark-surface/50'`.
- `bgMaterial` — Tailwind color override. Default: `'bg-md-light-surface-2 dark:bg-md-dark-surface-2'`.
- `tabbarHighlightBgIos` — Tailwind color override. Default: `''`.
- `tabbarHighlightBgMaterial` — Tailwind color override. Default: `'bg-md-light-primary dark:bg-md-dark-primary'`.

## Example
```tsx
<Toolbar>
  <Link>Cancel</Link>
  <ToolbarPane>Editor</ToolbarPane>
  <Link>Done</Link>
</Toolbar>
```
