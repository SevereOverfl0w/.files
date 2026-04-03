# Menu List React Component

Docs: https://konstaui.com/react/menu-list

## Purpose
Menu List is an extension of [List View](/react/list). Menu List unlike usual links list is designed to indicate currently active screen (or section) of your app. Think about it like a [Tabbar](/react/tabbar) but in a form of a list.

## Forwarded / Implicit HTML Props
- `MenuList`: Any remaining props are forwarded to the underlying `List` with `menuList` enabled. The root element therefore defaults to `<div>`.
- `MenuListItem`: Any remaining props are forwarded to the underlying `ListItem`. Its root defaults to `<li>`, and link behavior is controlled by `href`/`link` semantics on that inner component.

## MenuListItem Props Summary
- `active` (boolean) — Makes menu list item highlighted (active) Default: `false`.
- `href` (string | boolean) — Menu list item link's `href` attribute
- `media` (React.ReactNode) — Content of the media area (e.g. icon)
- `subtitle` (string | number | React.ReactNode) — Content of the menu list item "subtitle" area

## Example
```tsx
<MenuList strong inset>
  <MenuListItem active title="Overview" />
  <MenuListItem title="Analytics" subtitle="Usage and trends" />
  <MenuListItem title="Settings" />
</MenuList>
```
