# Publish landing changes automatically

Connect the `dievas` Worker to the GitHub repository in Cloudflare. Cloudflare builds the static Jaspr landing page and publishes it when matching changes reach `master`.

## Configure Cloudflare Builds

Use these settings under the Worker’s **Settings → Build**:

| Setting | Value |
| --- | --- |
| Production branch | `master` |
| Root directory | Repository root (`/`) |
| Build command | `bash landing/tool/build_cloudflare.sh` |
| Deploy command | `npx wrangler@4 deploy` |
| Preview command | `npx wrangler@4 versions upload` |
| Build variable | `NODE_VERSION=22` |

The build script installs Dart 3.13.2 on Cloudflare’s Linux build image, resolves the landing dependencies, compiles Tailwind CSS, and runs Jaspr static generation. The root `wrangler.jsonc` deploys `landing/build/jaspr` using Workers static assets.

Under **Build watch paths**, replace the default `*` include with:

```text
landing/*
packages/dievas_tokens/*
wrangler.jsonc
```

Leave exclude paths empty. Token changes also trigger builds because the landing page imports that package. Disable preview builds if you want deployments only from `master`.

See [Cloudflare build configuration](https://developers.cloudflare.com/workers/ci-cd/builds/configuration/) and [build watch paths](https://developers.cloudflare.com/workers/ci-cd/builds/build-watch-paths/).

## Verify the deployment

Merge the configuration and build script into `master`, save the Cloudflare settings, and retry the failed build. Confirm the build log executes the build script before Wrangler deploys. Open the deployment URL and check the page, images, theme toggle, and stage tabs.

After verification, add `dievas.serticode.com` as a custom domain on the Worker and follow Cloudflare’s DNS instructions. Disable the Railway service after the custom domain serves the verified deployment.

The GitHub **Deploy — Landing** workflow is a manual fallback. It requires `CLOUDFLARE_ACCOUNT_ID` and a `CLOUDFLARE_API_TOKEN` with Workers deployment permissions; Cloudflare Git builds use their own configured credentials.
