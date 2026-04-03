# Popover React Component

Docs: https://konstaui.com/react/popover

## Purpose
Popover component is used to manage the presentation of content in a popover. You use popovers to present information temporarily. The popover remains visible until the user taps outside of the popover window or you explicitly dismiss it.

## Forwarded / Implicit HTML Props
- `Popover`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`. The `style` prop is merged with Konsta-computed positioning.

## Popover Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `angle` (boolean) — Renders popover "angle"/"corner" Default: `false`.
- `angleClassName` (string) — Additional css class to add on "angle"/"corner" element Default: `undefined`.
- `opened` (boolean) — Allows to open/close Popover and set its initial state Default: `false`.
- `backdrop` (boolean) — Enables Popover backdrop (dark semi transparent layer behind) Default: `true`.
- `onBackdropClick` ((e: any) => void) — Click handler on backdrop element
- `target` (React.Ref<HTMLElement> | HTMLElement | string) — Popover target element. Popover will be positioned around this element
- `targetX` (number) — Virtual target element horizontal offset from left side of the screen. Required without using real target element (`target` prop)
- `targetY` (number) — Virtual target element vertical offset from top of the screen. Required without using real target element (`target` prop)
- `targetWidth` (number) — Virtual target element width (in px). Required without using real target element (`target` prop)
- `targetHeight` (number) — Virtual target element height (in px). Required without using real target element (`target` prop)
- `Popover.style` (React.CSSProperties) — Inline style object merged with Konsta-computed popover positioning styles. Default: `{}`.

### Popover `colors` keys
- `bgIos` — Tailwind color override. Default: `'bg-ios-light-glass dark:bg-ios-dark-glass'`.
- `bgMaterial` — Tailwind color override. Default: `'bg-md-light-surface-3 dark:bg-md-dark-surface-3'`.

## Example
```tsx
function Example() {
  const [opened, setOpened] = useState(false);
  const targetRef = useRef(null);

  return (
    <>
      <Button ref={targetRef} onClick={() => setOpened(true)}>Open popover</Button>
      <Popover
        opened={opened}
        target={targetRef.current}
        onBackdropClick={() => setOpened(false)}
      >
        <Block>Popover content</Block>
      </Popover>
    </>
  );
}
```
