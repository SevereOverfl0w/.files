# Toolbar Pane React Component

Docs: https://konstaui.com/react/toolbar-pane

## Purpose
Toolbar Pane is used in iOS theme to correctly wrap Toolbar content with "Glass"-effect elements. In Material theme it just bypasses its content and doesn't add any styling.

## Forwarded / Implicit HTML Props
- `ToolbarPane`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.

## ToolbarPane Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.

### ToolbarPane `colors` keys
- `tabbarHighlightBgIos` — Tailwind color override. Default: `'bg-black/10 dark:bg-white/15'`.

## Example
```tsx
<Toolbar>
  <Link>Cancel</Link>
  <ToolbarPane>Filters</ToolbarPane>
  <Link>Apply</Link>
</Toolbar>
```
