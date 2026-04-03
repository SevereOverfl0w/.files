# KonstaProvider

Docs: https://konstaui.com/react/konsta-provider

## Purpose
KonstaProvider supplies Konsta theme and global interaction settings when your outer app shell is not Konsta `App`.

## Forwarded / Implicit HTML Props
- `KonstaProvider`: `KonstaProvider` does not render its own DOM element, so extra props are not forwarded to HTML. It only provides context to descendants.

## KonstaProvider Props Summary
- `theme` ('ios' | 'material' | 'parent') — App theme. If set to `'parent'` it will look for `ios` or `md` class on root `<html>` element. Default: `'material'`.
- `dark` (boolean) — Include `dark:` variants (if dark theme is in use). Default: `false`.
- `materialTouchRipple` (boolean) — Enables touch ripple effect in Material theme. Default: `true`.
- `iosHoverHighlight` (boolean) — Enables touch highlight effect in iOS theme. Default: `true`.
- `KonstaProvider.autoThemeDetection` (boolean) — Controls whether theme is auto-detected from the surrounding environment when using `useAutoTheme`. Default: `true`.

## Example
```tsx
export default function Shell() {
  return (
    <KonstaProvider theme="ios">
      <div className="k-ios">
        <Page>
          <Navbar title="Embedded Konsta" />
        </Page>
      </div>
    </KonstaProvider>
  );
}
```
