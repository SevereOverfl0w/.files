# Link React Component

Docs: https://konstaui.com/react/link

## Purpose
Link is main component to create links for navigation, custom actions, switching tabs, open/close modals, etc.

## Forwarded / Implicit HTML Props
- `Link`: Any remaining props are forwarded to the root `component` element, defaulting to `<a>`.

## Link Props Summary
- `component` (string) — Component's HTML Element Default: `'a'`.
- `iconOnly` (boolean) — Enable if Link doesn't contain anything except icon Default: `false`.
- `tabbarActive` (boolean) — Highlights Tabbar Link as currently active Default: `false`.
- `linkProps` (any) — Object with additional props (attributes) to pass to the Link/Button
- `onClick` ((e: any) => void) — Click handler

### Link `colors` keys
- `textIos` — Tailwind color override. Default: `'text-primary'`.
- `textMaterial` — Tailwind color override. Default: `'text-md-light-primary dark:text-md-dark-primary'`.
- `navbarTextIos` — Tailwind color override. Default: `''`.
- `navbarTextMaterial` — Tailwind color override. Default: `''`.
- `toolbarTextIos` — Tailwind color override. Default: `''`.
- `toolbarTextMaterial` — Tailwind color override. Default: `'text-md-light-primary dark:text-md-dark-primary'`.

## Example
```tsx
<Block strong inset className="space-y-2">
  <Link href="/settings">Open settings</Link>
  <Link component="button" onClick={refresh}>Refresh</Link>
</Block>
```
