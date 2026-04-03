# Button React Component

Docs: https://konstaui.com/react/button

## Purpose
Button is the core action element for clickable commands, links, and segmented-style actions.

## Forwarded / Implicit HTML Props
- `Button`: Any remaining props are forwarded to the root `component` element, defaulting to `<button>`. If `component` is omitted and `href` is provided, `Button` renders as `<a>`.

## Button Props Summary
- `component` (string) — Component's HTML Element Default: `'button'`.
- `href` (string) — Link's `href` attribute, when specified will also be rendered as `<a>` element
- `outline` (boolean) — Makes button outline. Overwrites `outlineIos` and `outlineMaterial` props Default: `undefined`.
- `outlineIos` (boolean) — Makes button outline in iOS theme Default: `false`.
- `outlineMaterial` (boolean) — Makes button outline in Material theme Default: `false`.
- `clear` (boolean) — Makes button in clear style (without fill color). Overwrites `clearIos` and `clearMaterial` props Default: `undefined`.
- `clearIos` (boolean) — Makes button in clear style (without fill color) in iOS theme Default: `false`.
- `clearMaterial` (boolean) — Makes button in clear style (without fill color) in Material theme Default: `false`.
- `tonal` (boolean) — Makes button in tonal style (with semitransparent fill color). Overwrites `tonalIos` and `tonalMaterial` props Default: `undefined`.
- `tonalIos` (boolean) — Makes button in tonal style (with semitransparent fill color) in iOS theme Default: `false`.
- `tonalMaterial` (boolean) — Makes button in tonal style (with semitransparent fill color) in Material theme Default: `false`.
- `rounded` (boolean) — Makes button rounded. Overwrites `roundedIos` and `roundedMaterial` props Default: `undefined`.
- `roundedIos` (boolean) — Makes button rounded in iOS theme Default: `false`.
- `roundedMaterial` (boolean) — Makes button rounded in Material theme Default: `false`.
- `small` (boolean) — Makes button small. Overwrites `smallIos` and `smallMaterial` props Default: `undefined`.
- `smallIos` (boolean) — Makes button small in iOS theme Default: `false`.
- `smallMaterial` (boolean) — Makes button small in Material theme Default: `false`.
- `large` (boolean) — Makes button large. Overwrites `largeIos` and `largeMaterial` props Default: `undefined`.

### Button `colors` keys
- `textIos` — Tailwind color override. Default: `'text-primary'`.
- `textMaterial` — Tailwind color override. Default: `'text-md-light-primary dark:text-md-dark-primary'`.
- `fillTextIos` — Tailwind color override. Default: `'text-white'`.
- `fillTextMaterial` — Tailwind color override. Default: `'text-md-light-on-primary dark:text-md-dark-on-primary'`.
- `fillBgIos` — Tailwind color override. Default: `'bg-primary active:bg-ios-primary-shade'`.
- `fillBgMaterial` — Tailwind color override. Default: `'bg-md-light-primary dark:bg-md-dark-primary'`.
- `fillTouchRipple` — Tailwind color override. Default: `'touch-ripple-white dark:touch-ripple-primary'`.
- `clearBgIos` — Tailwind color override. Default: `'bg-transparent active:bg-primary/15'`.
- `clearBgMaterial` — Tailwind color override. Default: `'bg-transparent'`.
- `outlineBgIos` — Tailwind color override. Default: `'bg-transparent active:bg-primary/15'`.
- `outlineBgMaterial` — Tailwind color override. Default: `'bg-transparent'`.
- `outlineBorderIos` — Tailwind color override. Default: `'border-primary'`.
- `outlineBorderMaterial` — Tailwind color override. Default: `'border-md-light-outline dark:border-md-dark-outline'`.
- `segmentedStrongTextIos` — Tailwind color override. Default: `'text-black'`.
- `segmentedStrongTextMaterial` — Tailwind color override. Default: `''`.
- `tonalBgIos` — Tailwind color override. Default: `'bg-primary/15 active:bg-primary/25'`.
- `tonalBgMaterial` — Tailwind color override. Default: `'bg-md-light-secondary-container dark:bg-md-dark-secondary-container'`.
- `tonalTextIos` — Tailwind color override. Default: `'text-primary'`.
- `tonalTextMaterial` — Tailwind color override. Default: `'text-md-light-on-secondary-container dark:text-md-dark-on-secondary-container'`.
- `touchRipple` — Tailwind color override. Default: `'touch-ripple-primary'`.
- `disabledText` — Tailwind color override. Default: `'text-black/30 dark:text-white/30'`.
- `disabledBg` — Tailwind color override. Default: `'bg-black/10 dark:bg-white/10'`.
- `disabledBorder` — Tailwind color override. Default: `'border-black/10 dark:border-white/10'`.

## Example
```tsx
<Block strong inset className="space-y-2">
  <Button large>Save</Button>
  <Button large outline>Cancel</Button>
  <Button small clear inline>Secondary action</Button>
</Block>
```
