# List Button React Component

Docs: https://konstaui.com/react/list-button

## Purpose
List Button is intended to be used inside of the [List React Component](/react/list).

## Forwarded / Implicit HTML Props
- `ListButton`: Any remaining props are forwarded to the root `component` element, defaulting to `<li>`.

## ListButton Props Summary
- `component` (string) — Component's HTML Element Default: `'li'`.
- `href` (string) — Button's link `href` attribute
- `target` (string) — Button's link `target` attribute
- `type` (string) — Button's `type` attribute (if rendered as `<button>` with `linkComponent: 'button'`) Default: `undefined`.
- `value` (any) — Button's `type` attribute (if rendered as `<button>` with `linkComponent: 'button'`)
- `linkComponent` (string) — Button HTML Element Default: `'a'`.
- `linkProps` (any) — Object with additional props (attributes) to pass to the Link/Button

### ListButton `colors` keys
- `textIos` — Tailwind color override. Default: `'text-primary'`.
- `textMaterial` — Tailwind color override. Default: `'text-md-light-primary dark:text-md-dark-primary'`.
- `bgIos` — Tailwind color override. Default: `'active:bg-primary/15'`.
- `bgMaterial` — Tailwind color override. Default: `''`.
- `touchRipple` — Tailwind color override. Default: `'touch-ripple-primary'`.

## Example
```tsx
<List strong inset>
  <ListButton onClick={refresh}>Refresh data</ListButton>
  <ListButton href="/settings">Open settings</ListButton>
</List>
```
