# Data Table React Component

Docs: https://konstaui.com/react/data-table

## Purpose
Data tables display sets of raw data. They usually appear in desktop enterprise products.

## Forwarded / Implicit HTML Props
- `Table`: Any remaining props are forwarded to the root `<table>` element.
- `TableHead`: Any remaining props are forwarded to the root `<thead>` element.
- `TableBody`: Any remaining props are forwarded to the root `<tbody>` element.
- `TableRow`: Any remaining props are forwarded to the root `<tr>` element.
- `TableCell`: Any remaining props are forwarded to the root cell element, which is `<th>` when `header` is true and otherwise `<td>`.

## TableRow Props Summary
- `header` (boolean) — Is located inside the TableHead

### TableRow `colors` keys
- `bgIos` — Table Row hover bg color Default: `'hover:bg-black/5 dark:hover:bg-white/10'`.
- `bgMaterial` — Table Row hover bg color Default: `'hover:bg-md-light-secondary-container dark:hover:bg-md-dark-secondary-container'`.
- `dividerMaterial` — Table Row divider color Default: `'border-md-light-outline dark:border-md-dark-outline'`.

## TableCell Props Summary
- `header` (boolean) — Is located inside the TableHead

### TableCell `colors` keys
- `textHeaderIos` — Table Cell header text color Default: `'text-black/45 dark:text-white/55'`.
- `textHeaderMaterial` — Table Cell header text color Default: `'text-md-light-on-surface-variant dark:text-md-dark-on-surface-variant'`.

## Example
```tsx
<Table>
  <TableHead>
    <TableRow header>
      <TableCell header>Name</TableCell>
      <TableCell header>Status</TableCell>
      <TableCell header>Score</TableCell>
    </TableRow>
  </TableHead>
  <TableBody>
    <TableRow>
      <TableCell>Alice</TableCell>
      <TableCell>Active</TableCell>
      <TableCell>42</TableCell>
    </TableRow>
  </TableBody>
</Table>
```
