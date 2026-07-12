# List Item React Component

Docs: https://konstaui.com/react/list-item

## Purpose
List Item is the main row primitive for list navigation, settings rows, and structured item content.

## Forwarded / Implicit HTML Props
- `ListItem`: Any remaining props are forwarded to the root `component` element, defaulting to `<li>`.

## ListItem Props Summary
- `component` (string) — Component's HTML Element Default: `'li'`.
- `mediaClassName` (string) — Additional class to add on item "media" element
- `innerClassName` (string) — Additional class to add on item "inner" element
- `innerChildren` (string | number | React.ReactNode) — Content of the item-inner
- `contentClassName` (string) — Additional class to add on item "content" element
- `contentChildren` (string | number | React.ReactNode) — Content of the item-content
- `titleFontSizeIos` (string) — Tailwind CSS class for item title font size in iOS theme Default: `'text-[17px]'`.
- `titleFontSizeMaterial` (string) — Tailwind CSS class for item title font size in Material theme Default: `'text-[16px]'`.
- `titleWrapClassName` (string) — Additional class to add on item "titleWrap" element
- `title` (string | number | React.ReactNode) — Content of the list item "title" area
- `subtitle` (string | number | React.ReactNode) — Content of the list item "subtitle" area
- `text` (string | number | React.ReactNode) — Content of the list item "text" area
- `after` (string | number | React.ReactNode) — Content of the list item "after" area
- `media` (string | number | React.ReactNode) — Content of the list item "media" area
- `header` (string | number | React.ReactNode) — Content of the list item "header" area
- `footer` (string | number | React.ReactNode) — Content of the list item "footer" area
- `menuListItem` (boolean) — Renders list item as menu list item (same as `<MenuListItem>`)
- `menuListItemActive` (boolean) — Makes menu list item highlighted (active) (same as `<MenuListItem active>`) Default: `false`.

### ListItem `colors` keys
- `primaryTextIos` — Tailwind color override. Default: `'text-black dark:text-white'`.
- `primaryTextMaterial` — Tailwind color override. Default: `'text-md-light-on-surface dark:text-md-dark-on-surface'`.
- `secondaryTextIos` — Tailwind color override. Default: `'text-black/55 dark:text-white/55'`.
- `secondaryTextMaterial` — Tailwind color override. Default: `'text-md-light-on-surface-variant dark:text-md-dark-on-surface-variant'`.
- `activeBgIos` — Tailwind color override. Default: `'active:bg-black/10 dark:active:bg-white/10'`.
- `activeBgMaterial` — Tailwind color override. Default: `''`.
- `groupTitleBgIos` — Tailwind color override. Default: `'bg-ios-light-surface-variant dark:bg-ios-dark-surface-variant'`.
- `groupTitleBgMaterial` — Tailwind color override. Default: `'bg-md-light-surface-2 dark:bg-md-dark-surface-2'`.
- `menuListItemTextIos` — Tailwind color override. Default: `'text-black dark:text-white'`.
- `menuListItemTextMaterial` — Tailwind color override. Default: `'text-md-light-on-surface-variant dark:text-md-dark-on-surface-variant'`.
- `menuListItemBgIos` — Tailwind color override. Default: `'active:bg-black/10 dark:active:bg-white/10'`.
- `menuListItemBgMaterial` — Tailwind color override. Default: `'bg-md-light-surface-1 dark:bg-md-dark-surface-1'`.
- `menuListItemActiveTextIos` — Tailwind color override. Default: `'text-primary dark:text-white'`.
- `menuListItemActiveTextMaterial` — Tailwind color override. Default: `'text-md-light-on-secondary-container dark:text-md-dark-on-secondary-container'`.
- `menuListItemActiveBgIos` — Tailwind color override. Default: `'bg-primary/15 dark:bg-primary'`.
- `menuListItemActiveBgMaterial` — Tailwind color override. Default: `'bg-md-light-secondary-container dark:bg-md-dark-secondary-container'`.
- `touchRipple` — Tailwind color override. Default: `'touch-ripple-black dark:touch-ripple-white'`.
- `groupTitleContactsTextIos` — Tailwind color override. Default: `'text-black/90 dark:text-white/90'`.
- `groupTitleContactsTextMaterial` — Tailwind color override. Default: `'text-md-light-primary dark:text-md-dark-primary'`.
- `groupTitleContactsBgIos` — Tailwind color override. Default: `'dark:bg-[#323234]'`.
- `groupTitleContactsBgMaterial` — Tailwind color override. Default: `'bg-transparent dark:bg-transparent'`.

## Example
```tsx
<List strong inset outline>
  <ListItem
    link
    title="Account"
    subtitle="Manage your profile"
    after="Personal"
  />
</List>
```
