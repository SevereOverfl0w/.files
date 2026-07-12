# Notification React Component

Docs: https://konstaui.com/react/notification

## Purpose
With Notification component you can show required messages that looks like Push (or Local) system notifications.

## Forwarded / Implicit HTML Props
- `Notification`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.

## Notification Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `button` (React.ReactNode) — Notification button content
- `icon` (string | React.ReactNode) — Notification icon HTML layout or image
- `title` (string | number | React.ReactNode) — Content of the notification "title" area
- `titleRightText` (string | number | React.ReactNode) — Content of the notification "title right text" area
- `subtitle` (string | number | React.ReactNode) — Content of the notification "subtitle" area
- `text` (string | number | React.ReactNode) — Content of the notification "text" area
- `opened` (boolean) — Allows to open/close Notification and set its initial state Default: `undefined`.
- `onClose` ((e: any) => void) — Click handler on to close element

### Notification `colors` keys
- `bgIos` — Notifiaction bg color in iOS theme Default: `'bg-ios-light-glass dark:bg-ios-dark-glass'`.
- `bgMaterial` — Notification bg color in Material theme Default: `'bg-md-light-surface-5 dark:bg-md-dark-surface-5'`.
- `titleIos` — Notification title color in IOS theme Default: `'text-black dark:text-white'`.
- `titleRightIos` — Notification right text color in IOS theme Default: `'text-black/45 dark:text-white/45'`.
- `titleRightMd` — Notification right text color in Material theme Default: `'text-md-light-on-surface-variant before:bg-md-light-on-surface-variant dark:text-md-dark-on-surface-variant before:dark:bg-md-dark-on-surface-variant'`.
- `subtitleIos` — Notification subtitle color in IOS theme Default: `'text-black dark:text-white'`.
- `textMaterial` — Notification text color in Material theme Default: `'text-md-light-on-surface-variant dark:text-md-dark-on-surface-variant'`.
- `deleteIconIos` — Notification Delete Icon color in IOS theme Default: `'fill-stone-400 active:fill-stone-200 dark:fill-stone-500 dark:active:fill-stone-700'`.
- `deleteIconMd` — Notification Delete Icon color in Material theme Default: `'text-md-light-on-surface-variant dark:text-md-dark-on-surface-variant'`.

## Example
```tsx
function Example() {
  const [opened, setOpened] = useState(true);

  return (
    <Notification
      opened={opened}
      title="Upload complete"
      text="Your file is ready."
      onBackdropClick={() => setOpened(false)}
    />
  );
}
```
