# Sheet React Component

Docs: https://konstaui.com/react/sheet

## Purpose
Sheet Modal is a special overlay type. Such modal allows to create custom picker overlays with custom content.

## Forwarded / Implicit HTML Props
- `Sheet`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.

## Sheet Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `opened` (boolean) — Allows to open/close Sheet modal and set its initial state Default: `false`.
- `backdrop` (boolean) — Enables Sheet modal backdrop (dark semi transparent layer behind) Default: `true`.
- `onBackdropClick` ((e: any) => void) — Click handler on backdrop element

### Sheet `colors` keys
- `bgIos` — Tailwind color override. Default: `'bg-ios-light-surface-1 dark:bg-ios-dark-surface-1'`.
- `bgMaterial` — Tailwind color override. Default: `'bg-md-light-surface dark:bg-md-dark-surface'`.

## Example
```tsx
function Example() {
  const [opened, setOpened] = useState(false);

  return (
    <>
      <Button onClick={() => setOpened(true)}>Open sheet</Button>
      <Sheet opened={opened} onBackdropClick={() => setOpened(false)}>
        <Toolbar>
          <ToolbarPane>Choose an option</ToolbarPane>
        </Toolbar>
        <List strong inset>
          <ListItem title="Option A" link />
          <ListItem title="Option B" link />
        </List>
      </Sheet>
    </>
  );
}
```
