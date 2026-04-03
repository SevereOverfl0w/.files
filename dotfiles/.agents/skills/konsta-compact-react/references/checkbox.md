# Checkbox React Component

Docs: https://konstaui.com/react/checkbox

## Purpose
Checkbox is a boolean form control used for independent on/off selection.

## Forwarded / Implicit HTML Props
- `Checkbox`: Any remaining props are forwarded to the root `component` element, defaulting to `<label>`.

## Checkbox Props Summary
- `component` (string) — Component's HTML Element Default: `'label'`.
- `defaultChecked` (boolean) — Defines whether the checkbox input is checked or not, for the case if it is uncontrolled component Default: `false`.
- `checked` (boolean) — Defines whether the checkbox input is checked or not Default: `false`.
- `indeterminate` (boolean) — Defines whether the checkbox input is in indeterminate state or not Default: `false`.
- `name` (string) — Checkbox input name
- `value` (any) — Checkbox input value
- `disabled` (boolean) — Defines whether the checkbox input is disabled Default: `false`.
- `readOnly` (boolean) — Defines whether the checkbox input is readonly Default: `false`.
- `onChange` ((e: any) => void) — Event will be triggered when checkbox state changed

### Checkbox `colors` keys
- `borderIos` — Tailwind color override. Default: `'border-black/30 dark:border-white/30'`.
- `borderMaterial` — Tailwind color override. Default: `'border-md-light-outline dark:border-md-dark-outline'`.
- `bgCheckedIos` — Tailwind color override. Default: `'bg-primary'`.
- `bgCheckedMaterial` — Tailwind color override. Default: `'bg-md-light-primary dark:bg-md-dark-primary'`.
- `borderCheckedIos` — Tailwind color override. Default: `'border-primary'`.
- `borderCheckedMaterial` — Tailwind color override. Default: `'border-md-light-primary dark:border-md-dark-primary'`.

## Example
```tsx
function Example() {
  const [done, setDone] = useState(false);

  return (
    <List strong inset>
      <ListItem
        label
        title="Mark task as complete"
        after={
          <Checkbox
            checked={done}
            onChange={(e) => setDone(e.target.checked)}
          />
        }
      />
    </List>
  );
}
```
