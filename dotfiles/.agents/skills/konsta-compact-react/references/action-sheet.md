# Action Sheet React Component

Docs: https://konstaui.com/react/action-sheet

## Purpose
Action Sheet is a slide-up pane for presenting the user with a set of alternatives for how to proceed with a given task.

You can also use action sheets to prompt the user to confirm a potentially dangerous action.

The action sheet contains an optional title and one or more buttons, each of which corresponds to an action to take.

## Forwarded / Implicit HTML Props
- `Actions`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.
- `ActionsButton`: Any remaining props are forwarded to the root `component` element, defaulting to `<button>`.
- `ActionsLabel`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.
- `ActionsGroup`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.

## Actions Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `opened` (boolean) — Allows to open/close Action Sheet and set its initial state Default: `false`.
- `backdrop` (boolean) — Enables Action Sheet backdrop (dark semi transparent layer behind) Default: `true`.
- `onBackdropClick` ((e: any) => void) — Click handler on backdrop element

## ActionsButton Props Summary
- `component` (string) — Component's HTML Element Default: `'button'`.
- `href` (string) — Link's `href` attribute, when specified will also be rendered as `<a>` element
- `bold` (boolean) — Makes button text bold. Overwrites `boldIos` and `boldMaterial` Default: `undefined`.
- `boldIos` (boolean) — Makes button text bold in iOS theme Default: `false`.
- `boldMaterial` (boolean) — Makes button text bold in Material theme Default: `false`.
- `fontSizeIos` (string) — Button text font size in iOS theme Default: `'text-xl'`.
- `fontSizeMaterial` (string) — Button text font size in Material theme Default: `'text-base'`.
- `dividers` (boolean) — Renders button outer hairlines (borders). If not specified, will be enabled for iOS theme Default: `undefined`.

### ActionsButton `colors` keys
- `bgIos` — Tailwind color override. Default: `''`.
- `bgMaterial` — Tailwind color override. Default: `''`.
- `activeBgIos` — Tailwind color override. Default: `'active:bg-black/10 dark:active:bg-white/5'`.
- `activeBgMaterial` — Tailwind color override. Default: `''`.
- `textIos` — Tailwind color override. Default: `'text-primary'`.
- `textMaterial` — Tailwind color override. Default: `'text-md-light-on-surface dark:text-md-dark-on-surface'`.

## ActionsLabel Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `fontSizeIos` (string) — Button text font size in iOS theme Default: `'text-sm'`.
- `fontSizeMaterial` (string) — Button text font size in Material theme Default: `'text-sm'`.
- `dividers` (boolean) — Renders button outer hairlines (borders). If not specified, will be enabled in iOS theme Default: `undefined`.

### ActionsLabel `colors` keys
- `bgIos` — Tailwind color override. Default: `''`.
- `bgMaterial` — Tailwind color override. Default: `''`.
- `textIos` — Tailwind color override. Default: `'text-black/55 dark:text-white/55'`.
- `textMaterial` — Tailwind color override. Default: `'text-md-light-primary dark:text-md-dark-primary'`.

## ActionsGroup Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `dividers` (boolean) — Renders group outer hairlines (borders). (in Material theme only) Default: `true`.

### ActionsGroup `colors` keys
- `bgIos` — Tailwind color override. Default: `''`.
- `bgMaterial` — Tailwind color override. Default: `'bg-md-light-surface-3 dark:bg-md-dark-surface-3'`.

## Example
```tsx
function Example() {
  const [opened, setOpened] = useState(false);

  return (
    <>
      <Button onClick={() => setOpened(true)}>More actions</Button>
      <Actions opened={opened} onBackdropClick={() => setOpened(false)}>
        <ActionsGroup>
          <ActionsLabel>Choose an action</ActionsLabel>
          <ActionsButton onClick={() => setOpened(false)}>Save draft</ActionsButton>
          <ActionsButton className="text-red-500" onClick={() => setOpened(false)}>
            Delete
          </ActionsButton>
        </ActionsGroup>
        <ActionsGroup>
          <ActionsButton bold onClick={() => setOpened(false)}>Cancel</ActionsButton>
        </ActionsGroup>
      </Actions>
    </>
  );
}
```
