# CLAUDE.md

## What this is
A learning pet project: an isometric pixel game in Odin + raylib. The point of
the project is for the owner — an experienced Go backend engineer — to learn
low-level programming and manual memory management deliberately. Shipping fast
is explicitly NOT a goal.

The owner writes the game logic himself, following tutorials. Your role is
scaffolding, build/debug help, and explanation — not writing the game ahead of
him. Do not implement features that weren't asked for, and do not race ahead of
where he is in a tutorial.

## How to help here
- Prefer explaining over just doing. When a low-level or memory concept comes up
  (allocators, the `context` system, ownership, lifetimes), say what's happening
  and why — concisely.
- Keep code minimal and readable. No speculative abstractions, no "for the
  future" generality, no premature splitting into packages.
- When he's stuck, help him understand the cause — don't just hand back a patch.

## Stack (strict)
- Language: Odin.
- Graphics: raylib via the built-in `vendor:raylib` binding
  (`import "vendor:raylib"`).
- No third-party bindings, no external package managers, no build tooling beyond
  the Odin toolchain.

## API accuracy — re-read this every session
Odin and the raylib bindings are weakly represented in training data, so there
is a HIGH risk of inventing procedures that don't exist or getting signatures
wrong. Therefore:
- Never guess function names or signatures. Verify against the actual binding in
  `vendor/raylib` inside the local Odin installation, and/or `odin doc`.
- If unsure about a specific API, mark it with a `// VERIFY` comment rather than
  writing a plausible-looking guess.
- Never report a successful build that you did not actually run.

## Build discipline
- Always actually compile before handing code back: run `odin build` (or
  `odin check`) and fix errors. Broken scaffolding is worse than no scaffolding
  in a learning project.

## Conventions
- Code comments in English, minimal — only where a low-level/memory concept
  genuinely needs explaining.
- Flat structure until there is a real reason to split into packages.

## Commands
- Build: `odin build .`
- Run:   `odin run .`

(Adjust these if the project layout changes.)