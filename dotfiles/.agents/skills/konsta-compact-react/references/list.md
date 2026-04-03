# List React Component

Docs: https://konstaui.com/react/list

## Purpose
List views are versatile and powerful user interface components frequently found in apps. A list view presents data in a scrollable list of multiple rows that may be divided into sections/groups.

List views have many purposes:

- To let users navigate through hierarchically structured data
- To present an indexed list of items
- To display detail information and controls in visually distinct groupings
- To present a selectable list of options

## Forwarded / Implicit HTML Props
- `List`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`. `List` renders an internal `<ul>` for its children.
- `ListGroup`: Any remaining props are forwarded to the inner `List nested` wrapper. The outer wrapper rendered by `ListGroup` itself is a fixed `<li>`.

## List Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `dividers` (boolean) — Renders dividers (borders) between list items, overwrites `dividersIos` and `dividersMaterial` Default: `undefined`.
- `dividersIos` (boolean) — Renders dividers (borders) between list items in iOS theme Default: `true`.
- `dividersMaterial` (boolean) — Renders dividers (borders) between list items in Material theme Default: `false`.
- `strong` (boolean) — Adds extra highlighting. Overwrites `strongIos` and `strongMaterial` Default: `undefined`.
- `strongIos` (boolean) — Adds extra highlighting in iOS theme Default: `false`.
- `strongMaterial` (boolean) — Adds extra highlighting in Material theme Default: `false`.
- `inset` (boolean) — Makes list block inset. Overwrites `insetIos` and `insetMaterial` Default: `undefined`.
- `insetIos` (boolean) — Makes list block inset in iOS theme Default: `false`.
- `insetMaterial` (boolean) — Makes list block inset in Material theme Default: `false`.
- `outline` (boolean) — Renders list outer borders. Overwrites `outlineIos` and `outlineMaterial` Default: `undefined`.
- `outlineIos` (boolean) — Renders list outer borders in iOS theme Default: `false`.
- `outlineMaterial` (boolean) — Renders list outer borders in Material theme Default: `false`.
- `nested` (boolean) — Removes hairlines/dividers and margins, useful for case nesting list block within other blocks Default: `false`.
- `menuList` (boolean) — Renders list as Menu List (same as `<MenuList>`)

### List `colors` keys
- `outlineIos` — Tailwind color override. Default: `'border-black/20 dark:border-white/15'`.
- `outlineMaterial` — Tailwind color override. Default: `'border-md-light-outline border-md-dark-outline'`.
- `strongBgIos` — Tailwind color override. Default: `'bg-ios-light-surface-1 dark:bg-ios-dark-surface-1'`.
- `strongBgMaterial` — Tailwind color override. Default: `'bg-md-light-surface-1 dark:bg-md-dark-surface-1'`.

## Example
```tsx
<List strong inset outline>
  <ListItem title="Profile" link />
  <ListItem title="Notifications" link after={<Badge>3</Badge>} />
  <ListItem title="Appearance" link />
</List>
```
