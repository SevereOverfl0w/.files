# Toggle React Component

Docs: https://konstaui.com/react/toggle

## Purpose


## Forwarded / Implicit HTML Props
- `Toggle`: Any remaining props are forwarded to the root `component` element, defaulting to `<label>`.

## Toggle Props Summary
- `component` (string) — Component's HTML Element Default: `'label'`.
- `defaultChecked` (boolean) — Defines whether the toggle input is checked or not, for the case if it is uncontrolled component Default: `false`.
- `checked` (boolean) — Defines whether the toggle input is checked or not Default: `false`.
- `name` (string) — Toggle input name
- `value` (any) — Toggle input value
- `disabled` (boolean) — Defines whether the toggle input is disabled or not Default: `false`.
- `readOnly` (boolean) — Defines whether the toggle input is readonly or not Default: `false`.
- `onChange` ((e: any) => void) — Toggle input `change` event handler

### Toggle `colors` keys
- `bgIos` — Tailwind color override. Default: `'bg-ios-light-surface-1-shade dark:bg-ios-dark-surface-1-tint'`.
- `checkedBgIos` — Tailwind color override. Default: `'bg-primary'`.
- `thumbBgIos` — Tailwind color override. Default: `'bg-white'`.
- `checkedThumbBgIos` — Tailwind color override. Default: `'bg-white'`.
- `bgMaterial` — Tailwind color override. Default: `'bg-md-light-surface-variant dark:bg-md-dark-surface-variant'`.
- `checkedBgMaterial` — Tailwind color override. Default: `'bg-md-light-primary dark:bg-md-dark-primary'`.
- `borderMaterial` — Tailwind color override. Default: `'border-md-light-outline dark:border-md-dark-outline'`.
- `checkedBorderMaterial` — Tailwind color override. Default: `'border-md-light-primary dark:border-md-dark-primary'`.
- `thumbBgMaterial` — Tailwind color override. Default: `'bg-md-light-outline dark:bg-md-dark-outline'`.
- `checkedThumbBgMaterial` — Tailwind color override. Default: `'bg-md-light-on-primary dark:bg-md-dark-on-primary'`.

## Example
```tsx
function Example() {
  const [enabled, setEnabled] = useState(true);

  return (
    <List strong inset>
      <ListItem
        title="Enable notifications"
        after={<Toggle checked={enabled} onChange={(e) => setEnabled(e.target.checked)} />}
      />
    </List>
  );
}
```
