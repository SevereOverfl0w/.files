---
name: cdp-cli
description: Use for browser testing/automation via Chrome DevTools Protocol (cdp-cli).
allowed-tools: Bash(cdp-cli:*)
---

# cdp-cli (latest stable)

Use this skill when a task says “test in browser”, “verify button flow”, “check console/network”, or “use cdp-cli”.

Assumptions:
- cdp-cli is stable and up to date
- default CDP URL is `http://localhost:9222`

## Rules

1. Discover target tab before acting:
   ```bash
   cdp-cli tabs
   ```
2. Prefer real user clicks:
   ```bash
   cdp-cli click <page> <selector> --user-gesture
   ```
3. Assert outcomes with `eval` (before/after facts), not visuals alone.

## Fast workflow (default)

```bash
# A) find/open page
cdp-cli tabs
cdp-cli new "http://localhost:8000/settings"   # if needed

# B) baseline
cdp-cli eval "localhost:8000/settings" "({url: location.href, title: document.title})"

# C) interact
cdp-cli fill "localhost:8000/settings" "2" "input"
cdp-cli click "localhost:8000/settings" "button" --user-gesture

# D) verify
cdp-cli eval "localhost:8000/settings" "(async () => {
  await new Promise(r => setTimeout(r, 500));
  return {ok: true};
})()"

# E) debug if failing
cdp-cli console "localhost:8000/settings" --inspect --type error --tail 100
cdp-cli network "localhost:8000/settings" --duration 3
```

## Reliable patterns

### Gesture-first click
```bash
cdp-cli click <page> <selector> --user-gesture
```
Use for activation-gated behavior (fullscreen/WebXR/etc.) and generally safer app-flow simulation.

### Async assertion block
```bash
cdp-cli eval "<page>" "(async () => {
  const before = /* read state */;
  await new Promise(r => setTimeout(r, 500));
  const after = /* read state */;
  return {before, after, changed: before !== after};
})()"
```

### Console triage with expanded objects
```bash
cdp-cli console <page> --inspect --type error --tail 200
```

## Command reference

```bash
cdp-cli tabs
cdp-cli new [url]
cdp-cli go <page> <url|back|forward|reload>
cdp-cli close <idOrTitle>

cdp-cli snapshot <page> [--format ax|text|dom]
cdp-cli eval <page> "<js>"
cdp-cli console <page> [--inspect] [--type error] [--tail N]
cdp-cli network <page> [--duration S] [--type fetch|xhr]

cdp-cli click <page> <selector> [--user-gesture] [--double]
cdp-cli fill <page> <value> <selector>
cdp-cli key <page> <key>

cdp-cli screenshot <page> --output <path>
```

## Definition of done for UI verification

Return these explicitly:
1. Page targeted
2. Action executed (with `--user-gesture` when clicking)
3. Assertion result (before/after values)
4. Any console/network errors found
5. Optional screenshot path
