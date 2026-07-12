# Page React Component

Docs: https://konstaui.com/react/page

## Purpose
Page is the main component to display and operate content.

If you use Konsta UI with [Framework7](https://framework7.io) or [Ionic](https://ionicframework.com), you probably don't need this component and you should use Page components (or similar) from these frameworks.

## Forwarded / Implicit HTML Props
- `Page`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.

## Page Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.

### Page `colors` keys
- `bgIos` — Tailwind color override. Default: `'bg-ios-light-surface dark:bg-ios-dark-surface'`.
- `bgMaterial` — Tailwind color override. Default: `'bg-md-light-surface dark:bg-md-dark-surface'`.

## Example
```tsx
<Page>
  <Navbar title="Home" />
  <Block strong inset>Page content goes here.</Block>
</Page>
```
