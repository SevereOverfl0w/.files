# Radio React Component

Docs: https://konstaui.com/react/radio

## Purpose
Radio is a single-choice form control typically used in mutually exclusive option groups.

## Forwarded / Implicit HTML Props
- `Radio`: Any remaining props are forwarded to the root `component` element, defaulting to `<label>`.

## Radio Props Summary
- `component` (string) — Component's HTML Element Default: `'label'`.
- `defaultChecked` (boolean) — Defines whether the radio input is checked or not, for the case if it is uncontrolled component Default: `false`.
- `checked` (boolean) — Defines whether the radio input is checked or not Default: `false`.
- `name` (string) — Radio input name
- `value` (any) — Radio input value
- `disabled` (boolean) — Defines whether the radio input is disabled Default: `false`.
- `readOnly` (boolean) — Defines whether the radio input is readonly Default: `false`.
- `onChange` ((e: any) => void) — Event will be triggered when radio state changed

### Radio `colors` keys
- `borderIos` — Tailwind color override. Default: `'border-black/30 dark:border-white/30'`.
- `borderMaterial` — Tailwind color override. Default: `'border-md-light-outline dark:border-md-dark-outline'`.
- `bgCheckedIos` — Tailwind color override. Default: `'bg-primary'`.
- `bgCheckedMaterial` — Tailwind color override. Default: `'bg-md-light-primary dark:bg-md-dark-primary'`.
- `borderCheckedIos` — Tailwind color override. Default: `'border-primary'`.
- `borderCheckedMaterial` — Tailwind color override. Default: `'border-md-light-primary dark:border-md-dark-primary'`.

## Example
```tsx
function Example() {
  const [value, setValue] = useState('daily');

  return (
    <List strong inset>
      <ListItem
        label
        title="Daily summary"
        after={<Radio checked={value === 'daily'} onChange={() => setValue('daily')} />}
      />
      <ListItem
        label
        title="Weekly summary"
        after={<Radio checked={value === 'weekly'} onChange={() => setValue('weekly')} />}
      />
    </List>
  );
}
```
