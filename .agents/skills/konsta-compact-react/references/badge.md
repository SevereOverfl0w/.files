# Badge React Component

Docs: https://konstaui.com/react/badge

## Purpose
Badge React component represents Badge element that can be used in lists, links, navigation bars, etc.

## Forwarded / Implicit HTML Props
- `Badge`: Any remaining props are forwarded to the root `component` element, defaulting to `<span>`.

## Badge Props Summary
- `component` (string) — Component's HTML Element Default: `'span'`.
- `small` (boolean) — Makes small badge

### Badge `colors` keys
- `bg` — Badge bg color Default: `'bg-primary'`.
- `text` — Badge text color Default: `'text-white'`.

## Example
```tsx
<List strong inset>
  <ListItem title="Notifications" after={<Badge>3</Badge>} />
  <ListItem title="Beta" after={<Badge small>New</Badge>} />
</List>
```
