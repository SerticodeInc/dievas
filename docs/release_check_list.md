# Release Checklist

## One-time setup — Automated publishing on pub.dev

Before the GitHub workflow can publish, each package needs automated
publishing enabled on pub.dev. You must be an uploader on the package.

1. Go to `https://pub.dev/packages/dievas_tokens/admin`
2. **Automated publishing** → **Enable publishing from GitHub Actions**
   - Repository: `Serticode/dievas`
   - Tag pattern: `dievas_tokens-v{{version}}`
   - Optionally require environment: `pub.dev-dievas_tokens`
3. Repeat for `https://pub.dev/packages/dievas/admin`
   - Tag pattern: `dievas-v{{version}}`
   - Environment: `pub.dev-dievas`

## Before you tag

- [ ] Update `CHANGELOG.md` with new entries
- [ ] Bump `version` in `pubspec.yaml`
- [ ] Run `dart pub publish --dry-run` — no warnings
- [ ] Run full analysis: `melos run analyze` — no issues
- [ ] Run tests: `melos run test` — all green
- [ ] Commit everything: `git add -A && git commit -m "release: v<version>"`

## Publish

```bash
# For dievas_tokens
git tag dievas_tokens-v<version>
git push origin dievas_tokens-v<version>

# For dievas (only after dievas_tokens publish completes)
git tag dievas-v<version>
git push origin dievas-v<version>
```

The GitHub workflow picks up the tag and publishes automatically.

## Verify

- [ ] Check `https://pub.dev/packages/<name>` for the new version
- [ ] Confirm pub.dev analysis passes (no red flags)
- [ ] Update consuming projects to depend on the new version

## Notes

- Tags are **manual** — the workflow never auto-bumps or auto-publishes
- `dievas_tokens` must be published **before** `dievas`
- OIDC trusted publishing only works with tag triggers, not manual dispatch
