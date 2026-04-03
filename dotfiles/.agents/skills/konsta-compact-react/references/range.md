# Range Slider React Component

Docs: https://konstaui.com/react/range

## Purpose
Range is a slider control for choosing a numeric value from a bounded interval.

## Forwarded / Implicit HTML Props
- `Range`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.

## Range Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `inputId` (string) — Range input id attribute
- `name` (string) — Range input name
- `value` (any) — Range value
- `defaultValue` (any) — Range value, in case of uncontrolled component
- `disabled` (boolean) — Defines whether the range input is disabled Default: `false`.
- `readOnly` (boolean) — Defines whether the range input is readonly Default: `false`.
- `step` (number) — Range step Default: `1`.
- `min` (number) — Range min value Default: `0`.
- `max` (number) — Range max value Default: `100`.
- `onInput` ((e: any) => void) — `input` event handler
- `onChange` ((e: any) => void) — `change` event handler
- `onFocus` ((e: any) => void) — `focus` event handler
- `onBlur` ((e: any) => void) — `blur` event handler

### Range `colors` keys
- `valueBgIos` — Tailwind color override. Default: `'bg-primary'`.
- `valueBgMaterial` — Tailwind color override. Default: `'bg-md-light-primary dark:bg-md-dark-primary'`.
- `thumbBgIos` — Tailwind color override. Default: `'bg-white'`.
- `thumbBgMaterial` — Tailwind color override. Default: `'bg-md-light-primary dark:bg-md-dark-primary'`.

## Example
```tsx
function Example() {
  const [score, setScore] = useState(5);

  return (
    <Block strong inset>
      <div className="mb-2 text-sm">Intensity: {score}</div>
      <Range min={0} max={10} step={1} value={score} onChange={(e) => setScore(Number(e.target.value))} />
    </Block>
  );
}
```
