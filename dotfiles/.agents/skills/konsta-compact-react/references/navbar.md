# Navbar React Component

Docs: https://konstaui.com/react/navbar

## Purpose
Navbar is a fixed area at the top of a screen that contains Page title and navigation elements.

## Forwarded / Implicit HTML Props
- `Navbar`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.
- `NavbarBackLink`: Any remaining props are forwarded to the root `component` element, defaulting to `<a>`.

## Navbar Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `fontSizeIos` (string) — Tailwind CSS class for font size in iOS theme Default: `'text-[17px]'`.
- `fontSizeMaterial` (string) — Tailwind CSS class for font size in Material theme Default: `'text-[16px]'`.
- `titleFontSizeIos` (string) — Tailwind CSS class for navbar title font size in iOS theme Default: `'text-[17px]'`.
- `titleFontSizeMaterial` (string) — Tailwind CSS class for navbar title font size in Material theme Default: `'text-[22px]'`.
- `titleMediumFontSizeIos` (string) — Tailwind CSS class for medium-sized navbar title font size in iOS theme Default: `'text-[24px]'`.
- `titleMediumFontSizeMaterial` (string) — Tailwind CSS class for medium-sized navbar title font size in Material theme Default: `'text-[24px]'`.
- `titleLargeFontSizeIos` (string) — Tailwind CSS class for large-sized navbar title font size in iOS theme Default: `'text-[34px]'`.
- `titleLargeFontSizeMaterial` (string) — Tailwind CSS class for large-sized navbar title font size in Material theme Default: `'text-[28px]'`.
- `bgClassName` (string) — Additional class to add on Navbar's "background" element
- `innerClassName` (string) — Additional class to add on Navbar's "inner" element
- `leftClassName` (string) — Additional class to add on Navbar's "left" element
- `titleClassName` (string) — Additional class to add on Navbar's "title" element
- `subtitleClassName` (string) — Additional class to add on Navbar's "subtitle" element
- `rightClassName` (string) — Additional class to add on Navbar's "right" element
- `subnavbarClassName` (string) — Additional class to add on Navbar's "subnavbar" element
- `outline` (boolean) — Material theme only: Renders outer hairlines (borders) Default: `undefined`.
- `medium` (boolean) — Renders medium-sized navbar with extra row for medium-sized title which becomes usual size on scroll Default: `false`.

### Navbar `colors` keys
- `bgIos` — Tailwind color override. Default: `'bg-gradient-to-b from-ios-light-surface to-transparent dark:from-ios-dark-surface/50'`.
- `bgMaterial` — Tailwind color override. Default: `'bg-md-light-surface-2 dark:bg-md-dark-surface-2'`.
- `textIos` — Tailwind color override. Default: `'text-black dark:text-white'`.
- `textMaterial` — Tailwind color override. Default: `'text-md-light-on-surface dark:text-md-dark-on-surface'`.

## NavbarBackLink Props Summary
- `component` (string) — Component's HTML Element Default: `'a'`.
- `text` (string | React.ReactNode) — Text content of the back link Default: `'Back'`.
- `showText` (boolean) — Defines whether to show the link text. When 'auto', it hides link text for Material theme Default: `false`.
- `onClick` ((e: any) => void) — Link click handler

## Example
```tsx
<Navbar
  title="Inbox"
  left={<NavbarBackLink onClick={() => history.back()} />}
  right={<Link>Edit</Link>}
/>
```
