# Tabbar React Component

Docs: https://konstaui.com/react/tabbar

## Purpose
Tabbar is a particular case of [Toolbar](/react/toolbar), but it contains icons (or icons with labels) instead of plain links and inteded to be used to switch Tabs

## Forwarded / Implicit HTML Props
- `Tabbar`: Any remaining props are forwarded to the underlying `Toolbar`; its root element defaults to `<div>`.
- `TabbarLink`: Any remaining props are merged with `linkProps` and forwarded to the underlying `Link`; its root element defaults to `<a>`.

## Tabbar Props Summary
- `labels` (boolean) — Enables Tabbar with labels Default: `false`.
- `icons` (boolean) — Enables Tabbar with icons Default: `false`.

## TabbarLink Props Summary
- `active` (boolean) — Makes this tabbar link active Default: `false`.
- `component` (string) — Component's HTML Element Default: `'a'`.
- `linkProps` (any) — Object with additional props (attributes) to pass to the Link/Button
- `icon` (React.ReactNode) — Link icon content
- `label` (string | React.ReactNode) — Link label content

### TabbarLink `colors` keys
- `textIos` — Tailwind color override. Default: `'text-black dark:text-white'`.
- `textActiveIos` — Tailwind color override. Default: `'text-primary'`.
- `textMaterial` — Tailwind color override. Default: `'text-md-light-on-surface-variant dark:text-md-dark-on-surface-variant'`.
- `textActiveMaterial` — Tailwind color override. Default: `'text-md-light-on-secondary-container dark:text-md-dark-on-secondary-container'`.
- `iconBgIos` — Tailwind color override. Default: `''`.
- `iconBgActiveIos` — Tailwind color override. Default: `''`.
- `iconBgMaterial` — Tailwind color override. Default: `''`.
- `iconBgActiveMaterial` — Tailwind color override. Default: `'bg-md-light-secondary-container dark:bg-md-dark-secondary-container'`.

## Example
```tsx
<Tabbar labels icons>
  <TabbarLink active icon={<HomeIcon />} label="Home" />
  <TabbarLink icon={<ChartIcon />} label="Reports" />
  <TabbarLink icon={<SettingsIcon />} label="Settings" />
</Tabbar>
```
