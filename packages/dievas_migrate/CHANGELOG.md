<!-- meta.contentType: Reference -->

# Changelog

Changes to the Dievas migration CLI, newest first.

## 0.1.0

- Add `dievas_migrate`, a type-aware codemod that rewrites the pre-lowercase token names read from `dart analyze` diagnostics.
- Migrate class-scoped scales, role tokens, and radius extras on the token and theme-mirror types, guarding named parameters by their enclosing call.
- Rewrite `[context.spacing.MD]`-style doc-comment references in a separate text pass.
- Verify every pass against the analyzer and restore all files when the error count does not fall. Support dry run, `--write`, and `--check`.
