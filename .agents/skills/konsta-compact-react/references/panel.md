# Panel React Component

Docs: https://konstaui.com/react/panel

## Purpose
Panel renders left or right side panels that slide over or alongside the main page content.

## Forwarded / Implicit HTML Props
- `Panel`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.

## Panel Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `side` ('left' | 'right') — Panel side Default: `'left'`.
- `opened` (boolean) — Allows to open/close Panel and set its initial state Default: `false`.
- `floating` (boolean) — When enabled opened panel will have extra spaces from sides Default: `false`.
- `backdrop` (boolean) — Enables Panel backdrop (dark semi transparent layer behind) Default: `true`.
- `onBackdropClick` ((e: any) => void) — Click handler on backdrop element

### Panel `colors` keys
- `bgIos` — Panel bg color Default: `'bg-white dark:bg-black'`.
- `bgMaterial` — Panel bg color Default: `'bg-md-light-surface dark:bg-md-dark-surface'`.
- `floatingBgIos` — Panel bg color Default: `'bg-ios-light-glass dark:bg-ios-dark-glass'`.
- `floatingBgMaterial` — Panel bg color Default: `'bg-md-light-surface dark:bg-md-dark-surface'`.

## Example
```tsx
function Example() {
  const [opened, setOpened] = useState(true);

  return (
    <Panel left opened={opened} onBackdropClick={() => setOpened(false)}>
      <Page>
        <Navbar title="Menu" />
        <List strong inset>
          <ListItem title="Overview" link />
          <ListItem title="Settings" link />
        </List>
      </Page>
    </Panel>
  );
}
```
