---
name: konsta-compact-react
description: Compact Konsta UI React reference. Use this first for source-grounded component roles and the highest-signal props from the local reference files. Open the per-component reference files for colors, defaults, forwarded HTML props, types, event handlers, class-name hooks, theme variants, and full details.
---

# Konsta UI React Skill

## Common Package Info
- Install: `npm i konsta`
- React import path: `konsta/react`
- Theme CSS import: `@import "konsta/react/theme.css";`
- Installed React type declarations: `node_modules/konsta/react/types/<Component>.d.ts`
- Aggregate React declarations: `node_modules/konsta/react/konsta-react.d.ts`
- Canonical docs base: `https://konstaui.com/react/`

## Rules For Using This Skill
- Use this file for **component role/purpose** and **high-signal props** only.
- The role text below is taken from the local reference files' `## Purpose` sections, compressed but not invented.
- The prop lists below are trimmed from the local reference files' `## ... Props Summary` sections.
- **Colors are intentionally omitted here.** Open the reference file for any `colors` keys.
- Also open the reference file for event handlers, class-name props, `...Ios` / `...Material` variants, defaults, forwarded HTML props, examples, and any nuance not shown here.
- If a component has no explicit prop summary or purpose in the reference, do not invent one; defer to the reference file and/or `node_modules/konsta/react/types/<Component>.d.ts`.

## App Shell / Providers
- **App** — main app component that allows to define globals ref: `references/app.md`
- **KonstaProvider** like App, but when your outer app shell is not Konsta `App` — ref: `references/konsta-provider.md`
- **Page** — main component to display and operate content, probably not needed with ionic or framework7; ref: `references/page.md`

## Blocks / Cards / Surface Containers
- **Block** — content block for extra formatting and spacing for text content; props: `strong`, `inset`, `outline`, `nested`; ref: `references/block.md`
- **BlockTitle** — block title; props: `medium`, `large`; ref: `references/block.md`
- **BlockHeader** — block header; props: `inset`; ref: `references/block.md`
- **BlockFooter** — block footer; props: `inset`; ref: `references/block.md`
- **Card** — contains unique related data and is typically an entry point to more complex and detailed information; props: `header`, `footer`, `contentWrap`, `contentWrapPadding`, `outline`, `raised`, `headerDivider`, `footerDivider`; ref: `references/card.md`
- **ToolbarPane** — in iOS theme wraps toolbar content with glass-effect elements; in Material it just bypasses content without extra styling; ref: `references/toolbar-pane.md`

## Buttons / Links / Small Action Primitives
- **Button** — core action element for clickable commands, links, and segmented-style actions; props: `href`, `outline`, `clear`, `tonal`, `rounded`, `small`, `large`; ref: `references/button.md`
- **Fab** — promoted action with floating action button behavior; props: `href`, `text`, `textPosition`, `icon`; ref: `references/fab.md`
- **Link** — main component for links, navigation, custom actions, switching tabs, and opening/closing modals; props: `iconOnly`, `tabbarActive`, `linkProps`; ref: `references/link.md`
- **Badge** — badge element usable in lists, links, navigation bars, etc.; props: `small`; ref: `references/badge.md`
- **Chip** — compact element for tags, filters, selections, and removable tokens; props: `media`, `deleteButton`, `outline`; ref: `references/chip.md`
- **Icon** — renders icon content with Konsta-friendly sizing and theme-aware alignment; props: `badge`, `ios`, `material`, `badgeColors`; ref: `references/icon.md`

## Lists / List Rows / Menu Lists
- **List** — scrollable list of rows that may be divided into sections/groups; used for hierarchical data, indexed items, grouped details/controls, and selectable options; props: `dividers`, `strong`, `inset`, `outline`, `nested`, `menuList`; ref: `references/list.md`
- **ListGroup** — list subgroup wrapper; ref: `references/list.md`
- **ListItem** — main row primitive for list navigation, settings rows, and structured item content; props: `title`, `subtitle`, `text`, `after`, `media`, `header`, `footer`, `menuListItem`, `menuListItemActive`; ref: `references/list-item.md`
- **ListButton** — intended to be used inside `List`; props: `href`, `target`, `type`, `value`, `linkComponent`, `linkProps`; ref: `references/list-button.md`
- **MenuList** — extension of List View designed to indicate the currently active screen or section, like a tabbar in list form; ref: `references/menu-list.md`
- **MenuListItem** — menu-list row for active-screen/section indication; props: `active`, `href`, `media`, `subtitle`; ref: `references/menu-list.md`
- **Contacts List** — not a separate component; a particular case of using `List` and `ListItem`; ref: `references/contacts-list.md`

## Navigation Structure
- **Breadcrumbs** — help users keep track of location in large hierarchical sites/apps; ref: `references/breadcrumbs.md`
- **BreadcrumbsItem** — breadcrumb item; props: `active`; ref: `references/breadcrumbs.md`
- **BreadcrumbsSeparator** — breadcrumb separator; ref: `references/breadcrumbs.md`
- **BreadcrumbsCollapsed** — collapsed breadcrumb element; ref: `references/breadcrumbs.md`
- **Navbar** — fixed area at the top of a screen containing page title and navigation elements; props: `outline`, `medium`; ref: `references/navbar.md`
- **NavbarBackLink** — navbar back link; props: `text`, `showText`; ref: `references/navbar.md`
- **Toolbar** — fixed area at the bottom or top of a screen containing navigation elements; props: `outline`, `tabbar`, `tabbarLabels`, `tabbarIcons`, `top`; ref: `references/toolbar.md`
- **Tabbar** — particular case of Toolbar with icons or icons plus labels, intended to switch tabs; props: `labels`, `icons`; ref: `references/tabbar.md`
- **TabbarLink** — tabbar link; props: `active`, `icon`, `label`; ref: `references/tabbar.md`
- **Segmented** — linear set of mutually exclusive buttons used to display different views / switch tabs; props: `raised`, `outline`, `strong`, `rounded`; ref: `references/segmented.md`
- **SegmentedButton** — segmented control button; props: `active`; ref: `references/segmented.md`

## Forms / Inputs / Selection Controls
- **ListInput** — form layout component built from List View pieces with additional input-specific features; props: `label`, `outline`, `floatingLabel`, `media`, `input`, `info`, `error`, `clearButton`, `dropdown`; ref: `references/list-input.md`
- **Checkbox** — boolean form control for independent on/off selection; props: `defaultChecked`, `checked`, `indeterminate`, `name`, `value`, `disabled`, `readOnly`; ref: `references/checkbox.md`
- **Radio** — single-choice form control for mutually exclusive option groups; props: `defaultChecked`, `checked`, `name`, `value`, `disabled`, `readOnly`; ref: `references/radio.md`
- **Toggle** — an on/off toggle; props: `defaultChecked`, `checked`, `name`, `value`, `disabled`, `readOnly`; ref: `references/toggle.md`
- **Range** — slider control for choosing a numeric value from a bounded interval; props: `value`, `defaultValue`, `step`, `min`, `max`, `disabled`, `readOnly`; ref: `references/range.md`
- **Stepper** — A input with attached + and - buttons; props: `value`, `defaultValue`, `input`, `inputType`, `buttonsOnly`, `rounded`, `small`, `large`, `onPlus`, `onMinus`; ref: `references/stepper.md`
- **Searchbar** — search through List View elements, or use as a visual UI component for custom search; props: `placeholder`, `value`, `disableButton`, `clearButton`; ref: `references/searchbar.md`
- **Messagebar** — toolbar for usage with Messages; props: `placeholder`, `value`, `disabled`, `size`, `outline`, `left`, `right`; ref: `references/messagebar.md`

## Data Display
- **Table** — raw-data display for desktop/enterprise-style tables; ref: `references/data-table.md`
- **TableHead** — table head wrapper; ref: `references/data-table.md`
- **TableBody** — table body wrapper; ref: `references/data-table.md`
- **TableRow** — table row; props: `header`; ref: `references/data-table.md`
- **TableCell** — table cell; props: `header`; ref: `references/data-table.md`
- **Preloader** — indeterminate loading feedback with native-looking iOS and Material styling; ref: `references/preloader.md`
- **Progressbar** — determinate progress indicator; props: `progress`; ref: `references/progressbar.md`

## Messaging / Feedback
- **Messages** — chat-style conversation layout wrapper with groups, titles, and message bubbles; ref: `references/messages.md`
- **Message** — message bubble/content entry in a Messages layout; props: `id`, `text`, `name`, `type`, `header`, `footer`, `textHeader`, `textFooter`, `avatar`; ref: `references/messages.md`
- **MessagesTitle** — messages title element; ref: `references/messages.md`
- **Notification** — required messages that look like push or local system notifications; props: `button`, `icon`, `title`, `titleRightText`, `subtitle`, `text`, `opened`; ref: `references/notification.md`
- **Toast** — brief feedback about an operation through a message on the screen; props: `button`, `position`, `opened`; ref: `references/toast.md`

## Overlays / Temporary Views
- **Actions** — slide-up pane for presenting alternatives for how to proceed with a task, including dangerous-action confirmation; props: `opened`, `backdrop`; ref: `references/action-sheet.md`
- **ActionsButton** — action sheet button; props: `href`, `bold`, `dividers`; ref: `references/action-sheet.md`
- **ActionsLabel** — action sheet label; props: `dividers`; ref: `references/action-sheet.md`
- **ActionsGroup** — action sheet group; props: `dividers`; ref: `references/action-sheet.md`
- **Dialog** — modal window for critical information or prompting for a decision; props: `title`, `content`, `buttons`, `opened`, `backdrop`; ref: `references/dialog.md`
- **DialogButton** — dialog button; props: `strong`, `disabled`; ref: `references/dialog.md`
- **Popup** — popup window with arbitrary HTML content over app content; part of Temporary Views; props: `opened`, `backdrop`; ref: `references/popup.md`
- **Popover** — temporary popover presentation that stays visible until dismissed or outside-tapped; props: `angle`, `opened`, `backdrop`, `target`, `targetX`, `targetY`, `targetWidth`, `targetHeight`; ref: `references/popover.md`
- **Sheet** — special overlay type for custom picker overlays with custom content; props: `opened`, `backdrop`; ref: `references/sheet.md`
- **Panel** — left or right side panel that slides over or alongside main page content; props: `side`, `opened`, `floating`, `backdrop`; ref: `references/panel.md`

## If Unsure
- Prefer the component whose **Purpose** text matches the intended interaction.
- For anything involving colors, defaults, types, forwarded props, class hooks, theme variants, or examples, open the listed ref file.
- If the ref does not explicitly state a prop or behavior, do not assume it.
