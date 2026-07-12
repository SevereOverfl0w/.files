# Messages React Component

Docs: https://konstaui.com/react/messages

## Purpose
Messages components build chat-style conversation layouts with message groups, titles, and individual message bubbles.

## Forwarded / Implicit HTML Props
- `Messages`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.
- `Message`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.
- `MessagesTitle`: Any remaining props are forwarded to the root `component` element, defaulting to `<div>`.

## Messages Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.

## Message Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.
- `id` (string) — Message id attribute
- `text` (string | React.ReactNode) — Message text
- `name` (string) — Message name
- `type` (string) — Message type: sent (default) or received Default: `'sent'`.
- `header` (string | React.ReactNode) — Content of the Message header
- `footer` (string | React.ReactNode) — Content of the Message footer
- `textHeader` (string) — Message header text
- `textFooter` (string) — Message footer text
- `avatar` (string | React.ReactNode) — Message user's avatar URL
- `onClick` ((e: any) => void) — Message click handler
- `Messages.id` (string) — Id attribute applied to the root messages element.
- `MessagesTitle.id` (string) — Id attribute applied to the root messages title element.

### Message `colors` keys
- `messageSent` — Tailwind color override. Default: `'text-white'`.
- `messageNameIos` — Tailwind color override. Default: `'text-black/45 dark:text-white/45'`.
- `messageNameMd` — Tailwind color override. Default: `'text-md-light-on-surface-variant dark:text-md-dark-on-surface-variant'`.
- `bubbleSentIos` — Tailwind color override. Default: `'bg-primary'`.
- `bubbleSentMd` — Tailwind color override. Default: `'bg-md-light-primary dark:bg-md-dark-primary dark:text-md-dark-on-primary'`.
- `bubbleReceivedIos` — Tailwind color override. Default: `'bg-[#e5e5ea] dark:bg-[#252525]'`.
- `bubbleReceivedMd` — Tailwind color override. Default: `'dark:bg-md-dark-surface-variant bg-[#e5e5ea]'`.

## MessagesTitle Props Summary
- `component` (string) — Component's HTML Element Default: `'div'`.

### MessagesTitle `colors` keys
- `titleMd` — Tailwind color override. Default: `'text-md-light-on-surface-variant dark:text-md-dark-on-surface-variant'`.

## Example
```tsx
<Messages>
  <MessagesTitle>Today</MessagesTitle>
  <Message type="received" name="Alex" text="Hello there!" />
  <Message type="sent" text="Hi, how are you?" />
</Messages>
```
