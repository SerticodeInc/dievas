# dievas_migrate

Rewrites the pre lowercase Dievas token names (`spacing.MD`, `buttonHeightXS`, `DievasRadiusSemantic.R28`) and component size members (`DievasButtonSize.MD`, `DievasAvatarSize.XL2`) to the current vocabulary (`spacing.md`, `buttonHeightXs`, `DievasRadiusSemantic.r28`, `DievasButtonSize.md`, `DievasAvatarSize.xl2`).

The tool is type aware: it reads `dart analyze` diagnostics, so unrelated enums that reuse the same member names and display strings stay untouched.

## Usage

Upgrade `dievas_tokens` and `dievas` first. The old names must be undefined before the tool can see them.

```sh
# Preview every edit in the current directory. Writes nothing.
dart run dievas_migrate

# Apply the edits.
dart run dievas_migrate --write

# Fail a build when a migration is still pending.
dart run dievas_migrate --check

# Limit the run to specific paths.
dart run dievas_migrate --write lib test
```

| Option         | Effect                                                              |
| -------------- | ------------------------------------------------------------------- |
| `paths`        | Files or directories to migrate. Defaults to the current directory. |
| `--write`      | Apply the edits. Without it the run is a dry run.                   |
| `--check`      | Exit 1 when any migration is pending, without writing.              |
| `-h`, `--help` | Print usage.                                                        |

Exit codes: `0` clean, `1` pending work with `--check`, `2` the run failed and every file was restored.

## How it works

1. `dart analyze --format=json` reports each old name as undefined.
2. Getter, method, enum-constant, and dot shorthand diagnostics carry their declaring type, so the tool only rewrites types in the renamed vocabulary.
3. Named parameters carry no type, so the tool checks the enclosing call (`DievasSpacingThemeData`, `copyWith`, and the other theme constructors).
4. Record typed theme values (`(SM: …, MD: …, LG: …)`) are rewritten by their literal keys.
5. Comments produce no diagnostics, so a separate text pass rewrites `[context.spacing.MD]`-style references.
6. After each pass the tool reanalyzes. If the error count does not fall, it restores every file and reports failure.

## What it leaves alone

- Unrelated types that reuse the same names, such as `UnrelatedSize.MD`.
- Colour roles, opacity, z-index, easing, animation intents, and `touchMin`.
- Display strings. Replace those by hand when they are user visible.

## Development

```sh
dart test
dart analyze .
dart format --line-length 120 .
```

`test/migration_integration_test.dart` builds a throwaway consumer project on a path dependency and runs the full analyzer round trip.
