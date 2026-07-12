# Breadcrumbs React Component

Docs: https://konstaui.com/react/breadcrumbs

## Purpose
Breadcrumbs allow users to keep track and maintain awareness of their
locations within the app or website. They should be used for large sites
and apps with hierarchically arranged pages.

## Forwarded / Implicit HTML Props
- `Breadcrumbs`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.
- `BreadcrumbsItem`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.
- `BreadcrumbsSeparator`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.
- `BreadcrumbsCollapsed`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.

## Breadcrumbs Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `fontSizeIos` (string) — Font size in iOS theme Default: `'text-[17px]'`.
- `fontSizeMaterial` (string) — Font size in Material theme Default: `'text-[14px]'`.

## BreadcrumbsItem Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `active` (boolean) — Marks breadcrumb item as active/current (usually last item in breadcrumbs) Default: `false`.

### BreadcrumbsItem `colors` keys
- `textIos` — Tailwind color override. Default: `'text-black/55 dark:text-white/55'`.
- `textMaterial` — Tailwind color override. Default: `'text-md-light-on-secondary-container dark:text-md-dark-on-secondary-container'`.
- `bgIos` — Tailwind color override. Default: `''`.
- `bgMaterial` — Tailwind color override. Default: `'bg-md-light-secondary-container dark:bg-md-dark-secondary-container'`.
- `textActiveIos` — Tailwind color override. Default: `'text-black dark:text-white'`.
- `textActiveMaterial` — Tailwind color override. Default: `'text-md-light-on-secondary-container dark:text-md-dark-on-secondary-container'`.

## BreadcrumbsSeparator Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.

## BreadcrumbsCollapsed Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.

### BreadcrumbsCollapsed `colors` keys
- `bgIos` — Tailwind color override. Default: `'bg-black/15 dark:bg-white/15'`.
- `bgMaterial` — Tailwind color override. Default: `'bg-md-light-secondary-container dark:bg-md-dark-secondary-container'`.
- `dotBgIos` — Tailwind color override. Default: `'bg-black dark:bg-white'`.
- `dotBgMaterial` — Tailwind color override. Default: `'bg-md-light-primary dark:bg-md-dark-primary'`.

## Example
```tsx
<Breadcrumbs>
  <BreadcrumbsItem component="a" href="/">Home</BreadcrumbsItem>
  <BreadcrumbsSeparator />
  <BreadcrumbsItem component="a" href="/projects">Projects</BreadcrumbsItem>
  <BreadcrumbsSeparator />
  <BreadcrumbsItem active>Konsta UI</BreadcrumbsItem>
</Breadcrumbs>
```
