# Toast React Component

Docs: https://konstaui.com/react/toast

## Purpose
Toasts provide brief feedback about an operation through a message on the screen.

## Forwarded / Implicit HTML Props
- `Toast`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.

## Toast Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `button` (React.ReactNode) — Toast button content
- `position` ('left' | 'center' | 'right') — Toast position (only on wide screens). Can be `left`, `center` or `right` Default: `'left'`.
- `opened` (boolean) — Allows to open/close Toast and set its initial state Default: `false`.

### Toast `colors` keys
- `bgIos` — Tailwind color override. Default: `'bg-ios-light-glass dark:bg-ios-dark-glass'`.
- `bgMaterial` — Tailwind color override. Default: `'bg-md-light-surface-5 dark:bg-md-dark-surface-5'`.
- `textIos` — Tailwind color override. Default: `''`.
- `textMaterial` — Tailwind color override. Default: `'text-md-light-primary dark:text-md-dark-primary'`.

## Example
```tsx
function Example() {
  const [opened, setOpened] = useState(true);

  return (
    <Toast opened={opened} onToastClick={() => setOpened(false)}>
      Saved successfully
    </Toast>
  );
}
```
