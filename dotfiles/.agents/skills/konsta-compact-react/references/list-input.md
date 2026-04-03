# List Input React Component

Docs: https://konstaui.com/react/list-input

## Purpose
Form elements allow you to create flexible and beautiful Form layout. Form elements are just well known List View ([List](/react/list) and [List Item](/react/list-item) React components) but with few additional components.

## Forwarded / Implicit HTML Props
- `ListInput`: Any remaining props are forwarded to the underlying `ListItem` root, which defaults to `<li>`.

## ListInput Props Summary
- `component` (string) — Component's HTML Element Default: `'li'`.
- `label` (string | React.ReactNode) — Label content
- `outline` (boolean) — Renders outline-style input (with border around), overwrites `outlineIos` and `outlineMaterial` Default: `undefined`.
- `outlineIos` (boolean) — Renders outline-style input (with border around) in iOS theme Default: `false`.
- `outlineMaterial` (boolean) — Renders outline-style input (with border around) in Material theme Default: `false`.
- `floatingLabel` (boolean) — Makes floating label Default: `false`.
- `media` (string | React.ReactNode) — Content of the list item "media" area (e.g. icon)
- `input` (React.ReactNode) — Custom input element
- `info` (string | React.ReactNode) — Content of the input "info"
- `error` (string | boolean | React.ReactNode) — Content of the input "error"
- `clearButton` (boolean) — Adds input clear button Default: `false`.
- `dropdown` (boolean) — Renders additional dropdown icon (useful to use with `select` inputs) Default: `false`.
- `inputId` (string) — Input id attribute
- `inputStyle` (React.CSSProperties) — Additional input classes
- `inputClassName` (string) — Additional input styles
- `name` (string) — Input name
- `value` (any) — Input value
- `defaultValue` (any) — Input value, in case of uncontrolled component

### ListInput `colors` keys
- `bgIos` — Tailwind color override. Default: `''`.
- `bgMaterial` — Tailwind color override. Default: `'bg-md-light-surface-variant dark:bg-md-dark-surface-variant'`.
- `outlineBorderIos` — Tailwind color override. Default: `'border-black/30 dark:border-white/30'`.
- `outlineBorderFocusIos` — Tailwind color override. Default: `'border-primary'`.
- `outlineBorderMaterial` — Tailwind color override. Default: `'border-md-light-on-surface dark:border-md-dark-on-surface'`.
- `outlineBorderFocusMaterial` — Tailwind color override. Default: `'border-md-light-primary dark:border-md-dark-primary'`.
- `outlineLabelBgIos` — Tailwind color override. Default: `'bg-ios-light-surface-1 dark:bg-ios-dark-surface-1'`.
- `outlineLabelBgMaterial` — Tailwind color override. Default: `'bg-md-light-surface dark:bg-md-dark-surface'`.
- `labelTextIos` — Tailwind color override. Default: `''`.
- `labelTextFocusIos` — Tailwind color override. Default: `''`.
- `labelTextMaterial` — Tailwind color override. Default: `'text-md-light-on-surface-variant dark:text-md-dark-on-surface-variant'`.
- `labelTextFocusMaterial` — Tailwind color override. Default: `'text-md-light-primary dark:text-md-dark-primary'`.
- `errorText` — Tailwind color override. Default: `'text-red-500'`.
- `errorBorder` — Tailwind color override. Default: `'border-red-500'`.

## Example
```tsx
function Example() {
  const [email, setEmail] = useState('');

  return (
    <List strong inset>
      <ListInput
        label="Email"
        type="email"
        placeholder="name@example.com"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
        clearButton
      />
    </List>
  );
}
```
