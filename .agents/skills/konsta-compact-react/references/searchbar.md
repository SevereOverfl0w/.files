# Searchbar React Component

Docs: https://konstaui.com/react/searchbar

## Purpose
Searchbar allows user to search through [List View](/react/list) elements. Or it can be used as a visual UI component for your custom search realization.

## Forwarded / Implicit HTML Props
- `Searchbar`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.

## Searchbar Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `placeholder` (string | number) — Searchbar placeholder Default: `'Search'`.
- `value` (any) — Searchbar value
- `inputId` (string) — Input id attribute
- `inputStyle` (React.CSSProperties) — Additional input classes
- `disableButton` (boolean) — Adds button for cancel search and set its initial state Default: `false`.
- `clearButton` (boolean) — Adds input clear button Default: `true`.
- `onInput` ((e: any) => void) — `input` event handler
- `onChange` ((e: any) => void) — `change` event handler
- `onFocus` ((e: any) => void) — `focus` event handler
- `onBlur` ((e: any) => void) — `blur` event handler
- `onClear` ((e: any) => void) — Fired on clear button click
- `onDisable` ((e: any) => void) — Fired on searchbar disable

### Searchbar `colors` keys
- `inputBgIos` — Tailwind color override. Default: `''`.
- `inputBgMaterial` — Tailwind color override. Default: `'bg-md-light-secondary-container dark:bg-md-dark-secondary-container'`.
- `placeholderIos` — Tailwind color override. Default: `''`.
- `placeholderMaterial` — Tailwind color override. Default: `'placeholder-md-light-on-surface-variant dark:placeholder-md-dark-on-surface-variant'`.

## Example
```tsx
function Example() {
  const [query, setQuery] = useState('');

  return (
    <Searchbar
      value={query}
      onChange={(e) => setQuery(e.target.value)}
      disableButtonText="Cancel"
      placeholder="Search messages"
    />
  );
}
```
