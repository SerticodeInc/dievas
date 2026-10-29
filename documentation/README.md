# Dievas documentation

The dedicated documentation application lives in this directory, outside the Dart/Melos workspace.

## Scope

Help Flutter engineers install Dievas, build a first screen, customize themes, select components, and migrate existing applications. Use source verified examples and distinguish published APIs from workspace changes.

## Content map

- Start: installation and first screen
- Foundations: tokens, typography/spacing, layout, motion/accessibility
- Theming: scope, theme mode, brand palettes, component overrides
- Components: inventory, buttons, inputs, selection, feedback, overlays
- Recipes: forms, settings, confirmation
- Maintenance: migration, troubleshooting, API reference, contributing

## Release baseline

Verified against pub.dev on 29 October 2026: `dievas` 1.0.4 requires `dievas_tokens` ^1.0.3. Both require Dart >=3.11.4; the Flutter package declares Flutter >=3.22.0. Choose a Flutter SDK that also satisfies the Dart requirement. `dievas_migrate` is not published on pub.dev at this audit; its CLI instructions must run from its repository checkout.


## Develop and verify

Use Node >=22.23.4 and Flutter with Dart >=3.11.4 for the example verifier. From this directory:

```sh
npm ci
npm run dev
```

Production checks and preview:

```sh
npm run check
python3 scripts/verify-examples.py
npm run build
npm run verify:links
npm run preview
```

The example verifier resolves published package versions in a temporary consumer and runs four adoption-flow widget tests. Pagefind indexes the production build; check search in the built preview. Stop preview/dev processes after use.

## Deployment

The independent Cloudflare Worker is `dievas-documentation`. Its Wrangler configuration declares `docs.dievas.serticode.com` as a custom domain and retains a `workers.dev` address. The configured token needs Worker deployment and zone Workers Routes permissions to create the domain binding. See [Cloudflare custom domains](https://developers.cloudflare.com/workers/configuration/routing/custom-domains/).

The Documentation workflow checks pull requests and deploys pushes to `master`. It uses the repository's `CLOUDFLARE_ACCOUNT_ID` and `CLOUDFLARE_API_TOKEN` secrets. Do not put credentials in content or configuration files.

For a branch deployment before merge, use the existing manual deployment entrypoint:

```sh
gh workflow run deploy_landing.yml --ref branch_name \
  -f target=documentation -f reason='Review documentation deployment'
```

Replace `branch_name` with the branch under review. The landing target remains the default; selecting documentation deploys only the documentation Worker. Confirm the action result and public URL before reporting deployment success.

## Maintain content

Use the [contribution guide](https://docs.dievas.serticode.com/maintain/contributing/) for page contracts and release checks. Public API changes should update guides, examples, and migration instructions in the same PR. The documentation baseline targets published versions; the gallery can contain newer workspace APIs.
