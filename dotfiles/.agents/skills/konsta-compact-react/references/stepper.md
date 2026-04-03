# Stepper React Component

Docs: https://konstaui.com/react/stepper

## Forwarded / Implicit HTML Props
- `Stepper`: Any remaining props are forwarded to the root `component` element, defaulting to `<span>`.

## Stepper Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `value` (number) — Stepper value Default: `0`.
- `defaultValue` (number) — Stepper input default value, in case of uncontrolled component
- `input` (boolean) — Defines should it render <input> element or not Default: `false`.
- `inputType` (string) — Input type Default: `'text'`.
- `inputPlaceholder` (string) — Input placeholder
- `inputDisabled` (boolean) — Defines whether the stepper input is disabled or not Default: `false`.
- `inputReadOnly` (boolean) — Defines whether the stepper input is read only or not Default: `false`.
- `buttonsOnly` (boolean) — Disables inner value container between stepper buttons Default: `false`.
- `rounded` (boolean) — Makes stepper round. Overwrites `roundedIos` and `roundedMaterial` Default: `undefined`.
- `roundedIos` (boolean) — Makes stepper round in iOS theme Default: `false`.
- `roundedMaterial` (boolean) — Makes stepper round in Material theme Default: `false`.
- `small` (boolean) — Makes stepper small. Overwrites `smallIos` and `smallMaterial` Default: `undefined`.
- `smallIos` (boolean) — Makes stepper small in iOS theme Default: `false`.
- `smallMaterial` (boolean) — Makes stepper small in Material theme Default: `false`.
- `large` (boolean) — Makes stepper large. Overwrites `largeIos` and `largeMaterial` Default: `undefined`.
- `largeIos` (boolean) — Makes stepper large in iOS theme Default: `false`.
- `largeMaterial` (boolean) — Makes stepper large in Material theme Default: `false`.
- `onPlus` (callback) - What to do when pressing plus
- `onMinus` (callback) - What to do when pressing minus

### Stepper `colors` keys
- `textIos` — Tailwind color override. Default: `'text-primary'`.
- `textMaterial` — Tailwind color override. Default: `'text-md-light-primary dark:text-md-dark-primary'`.
- `fillTextIos` — Tailwind color override. Default: `'text-white'`.
- `fillTextMaterial` — Tailwind color override. Default: `'text-md-light-on-primary dark:text-md-dark-on-primary'`.
- `fillBgIos` — Tailwind color override. Default: `'bg-primary active:bg-ios-primary-shade''`.
- `fillBgMaterial` — Tailwind color override. Default: `'bg-md-light-primary dark:bg-md-dark-primary'`.
- `fillTouchRipple` — Tailwind color override. Default: `'touch-ripple-white dark:touch-ripple-primary'`.
- `clearBgIos` — Tailwind color override. Default: `'bg-transparent active:bg-primary/15'`.
- `clearBgMaterial` — Tailwind color override. Default: `'bg-transparent'`.
- `outlineBgIos` — Tailwind color override. Default: `'bg-transparent active:bg-primary/15'`.
- `outlineBgMaterial` — Tailwind color override. Default: `'bg-transparent'`.
- `outlineBorderIos` — Tailwind color override. Default: `'border-primary'`.
- `outlineBorderMaterial` — Tailwind color override. Default: `'border-md-light-outline dark:border-md-dark-outline'`.
- `touchRipple` — Tailwind color override. Default: `'touch-ripple-primary'`.

## Example
```tsx
function Example() {
  const [count, setCount] = useState(1);

  return (
    <Stepper
      value={count}
      onPlus={() => setCount((v) => v + 1)}
      onMinus={() => setCount((v) => Math.max(0, v - 1))}
    />
  );
}
```
