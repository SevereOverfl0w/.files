# Dialog React Component

Docs: https://konstaui.com/react/dialog

## Purpose
Dialog is a type of modal window that appears in front of app content to provide critical information, or prompt for a decision to be made.

## Forwarded / Implicit HTML Props
- `Dialog`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.
- `DialogButton`: Any remaining props are forwarded through to the underlying `Button`, whose root `component` defaults to `<button>`.

## Dialog Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `titleFontSizeIos` (string) — Tailwind CSS classes for title font size iOS theme Default: `'text-[17px]'`.
- `titleFontSizeMaterial` (string) — Tailwind CSS classes for title font size Material theme Default: `'text-[24px]'`.
- `title` (string | number | React.ReactNode) — Dialog title content
- `content` (string | number | React.ReactNode) — Dialog main content
- `buttons` (string | number | React.ReactNode) — Dialog buttons content
- `opened` (boolean) — Allows to open/close Popup and set its initial state Default: `false`.
- `backdrop` (boolean) — Enables Popup backdrop (dark semi transparent layer behind) Default: `true`.
- `onBackdropClick` ((e: any) => void) — Click handler on backdrop element

### Dialog `colors` keys
- `bgIos` — Dialog bg color in iOS theme Default: `'bg-ios-light-glass dark:bg-ios-dark-glass'`.
- `bgMaterial` — Dialog bg color in iOS theme Default: `'bg-md-light-surface-3 dark:bg-md-dark-surface-3'`.
- `titleIos` — Title text color in iOS theme Default: `''`.
- `titleMaterial` — Title text color in Material theme Default: `'text-md-light-on-surface dark:text-md-dark-on-surface'`.
- `contentTextIos` — Content text color in iOS theme Default: `''`.
- `contentTextMaterial` — Content text color in Material theme Default: `'text-md-light-on-surface-variant dark:text-md-dark-on-surface-variant'`.

## DialogButton Props Summary
- `component` (string) — Component's HTML Element Default: `'button'`.
- `onClick` ((e: any) => void) — DialogButton click handler
- `strong` (boolean) — Makes button bold in iOS theme and fill in Material theme, overwrites `strongIos` and `strongMaterial` Default: `false`.
- `strongIos` (boolean) — Makes button bold in iOS theme Default: `false`.
- `strongMaterial` (boolean) — Makes button fill in Material theme Default: `false`.
- `disabled` (boolean) — Makes button disabled Default: `false`.

## Example
```tsx
function Example() {
  const [opened, setOpened] = useState(false);

  return (
    <>
      <Button onClick={() => setOpened(true)}>Delete item</Button>
      <Dialog
        opened={opened}
        title="Delete item?"
        content="This action cannot be undone."
      >
        <DialogButton onClick={() => setOpened(false)}>Cancel</DialogButton>
        <DialogButton strong onClick={() => setOpened(false)}>Delete</DialogButton>
      </Dialog>
    </>
  );
}
```
