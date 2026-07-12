# Popup React Component

Docs: https://konstaui.com/react/popup

## Purpose
Popup is a popup window with any HTML content that pops up over App's main content. Popup as all other overlays is part of so called "Temporary Views".

## Forwarded / Implicit HTML Props
- `Popup`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.

## Popup Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `opened` (boolean) — Allows to open/close Popup and set its initial state Default: `false`.
- `backdrop` (boolean) — Enables Popup backdrop (dark semi transparent layer behind) Default: `true`.
- `onBackdropClick` ((e: any) => void) — Click handler on backdrop element

### Popup `colors` keys
- `bg` — Popup bg color Default: `'bg-white dark:bg-black'`.

## Example
```tsx
function Example() {
  const [opened, setOpened] = useState(false);

  return (
    <>
      <Button onClick={() => setOpened(true)}>Open popup</Button>
      <Popup opened={opened} onBackdropClick={() => setOpened(false)}>
        <Page>
          <Navbar title="Details" right={<Link onClick={() => setOpened(false)}>Close</Link>} />
          <Block strong inset>Popup content</Block>
        </Page>
      </Popup>
    </>
  );
}
```
