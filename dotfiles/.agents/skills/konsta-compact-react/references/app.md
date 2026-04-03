# App React Component

Docs: https://konstaui.com/react/app

## Purpose
App React component is the main app component that allows to define global theme (iOS or Material) and other useful globals.

If you use Konsta UI with other framework (like [Framework7](https://framework7.io) or [Ionic](https://ionicframework.com)), you should use [KonstaProvider](/react/konsta-provider) instead.

## Forwarded / Implicit HTML Props
- `App`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`. `App` wraps that element in `KonstaProvider` internally.

## App Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `theme` ('ios' | 'material' | 'parent') — App theme. If set to `'parent'` it will look for `ios` or `md` class on root `<html>` element, useful to use with parent framework like Framework7 or Ionic Default: `'material'`.
- `dark` (boolean) — Include `dark:` variants (if dark theme is in use) Default: `false`.
- `materialTouchRipple` (boolean) — Enables touch ripple effect in Material theme. Allows to globally disable touch ripple for all components Default: `true`.
- `iosHoverHighlight` (boolean) — Enables touch highlight effect in iOS theme. Allows to globally disable touch highlight for all components Default: `true`.
- `safeAreas` (boolean) — Adds `safe-areas` class to the container. Should be enabled if app container is the full screen element to properly handle screen safe areas Default: `true`.

## Example
```tsx
export default function AppShell() {
  return (
    <App theme="ios">
      <Page>
        <Navbar title="Dashboard" />
        <Block strong inset>Welcome to Konsta UI.</Block>
      </Page>
    </App>
  );
}
```
