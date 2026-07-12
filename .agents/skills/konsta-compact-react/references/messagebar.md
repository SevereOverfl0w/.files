# Messagebar React Component

Docs: https://konstaui.com/react/messagebar

## Purpose
Messagebar is a toolbar for usage with Messages

## Forwarded / Implicit HTML Props
- `Messagebar`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.

## Messagebar Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `id` (string) — Messagebar id attribute
- `style` (React.CSSProperties) — Additional messagebar classes
- `name` (string) — Messagebar name
- `placeholder` (string | number) — Messagebar placeholder Default: `'Message'`.
- `value` (any) — Messagebar value
- `textareaId` (string) — Textarea "id" attribute
- `disabled` (boolean) — Sets "disabled" textarea attribute Default: `undefined`.
- `size` (string | number) — Value of textarea's native "size" attribute
- `outline` (boolean) — Renders outer hairlines (borders). If not specified, will be enabled for iOS theme Default: `false`.
- `leftClassName` (string) — Additional left styles
- `rightClassName` (string) — Additional right styles
- `left` (string | number | React.ReactNode) — Content of the Messagebar's "left" area
- `right` (string | number | React.ReactNode) — Content of the Messagebar's "right" area
- `onInput` ((e: any) => void) — `input` event handler
- `onChange` ((e: any) => void) — `change` event handler
- `Messagebar.onFocus` ((e: any) => void) — Focus handler for the internal textarea.

### Messagebar `colors` keys
- `toolbarIconIos` — Tailwind color override. Default: `'fill-primary dark:fill-md-dark-primary'`.
- `toolbarIconMd` — Tailwind color override. Default: `'fill-black'`.
- `inputBgIos` — Tailwind color override. Default: `'bg-transparent'`.
- `borderIos` — Tailwind color override. Default: `'border-[#c8c8cd] dark:border-white/30'`.
- `inputBgMd` — Tailwind color override. Default: `'bg-md-light-surface-2 dark:bg-md-dark-surface-variant'`.
- `placeholderIos` — Tailwind color override. Default: `'dark:placeholder-white/40'`.
- `placeholderMd` — Tailwind color override. Default: `'placeholder-md-light-on-surface-variant dark:placeholder-md-dark-on-surface-variant'`.
- `bgIos` — Tailwind color override. Default: `''`.
- `bgMaterial` — Tailwind color override. Default: `'bg-md-light-surface dark:bg-md-dark-surface'`.

## Example
```tsx
function Example() {
  const [text, setText] = useState('');

  return (
    <Messagebar
      placeholder="Message"
      value={text}
      onChange={(e) => setText(e.target.value)}
      right={<Button small onClick={() => setText('')}>Send</Button>}
    />
  );
}
```
