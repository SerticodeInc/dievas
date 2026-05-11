# ─────────────────────────────────────────────────────────────────────────────
# Dievas Landing — Multi-stage Dockerfile
#
# Build context: REPO ROOT (not landing/)
#   docker build -f landing/Dockerfile .
#
# Railway sets this automatically via railway.toml buildContext = "."
# ─────────────────────────────────────────────────────────────────────────────

# ── Stage 1: Generate Tailwind CSS ────────────────────────────────────────────
FROM node:20-alpine AS css-builder
WORKDIR /build/landing

# Install Tailwind deps first (cached layer)
COPY landing/package*.json ./
RUN npm ci

# Copy Dart source so Tailwind can scan for class names
COPY landing/web/styles.css ./web/styles.css
COPY landing/lib/ ./lib/

# Generate minified output.css
RUN npx @tailwindcss/cli -i web/styles.css -o web/output.css --minify

# ── Stage 2: Build Jaspr Dart server ─────────────────────────────────────────
FROM dart:stable AS dart-builder
WORKDIR /build

# Copy workspace root pubspec so path resolution is consistent
COPY pubspec.yaml ./

# Copy dievas_tokens (path dependency for landing)
COPY packages/dievas_tokens/ ./packages/dievas_tokens/

# Copy landing package
COPY landing/ ./landing/

# Activate jaspr CLI globally (required for `jaspr build`)
RUN dart pub global activate jaspr_cli

# Resolve deps from within the landing package
WORKDIR /build/landing
RUN dart pub get

# Generate jaspr_options.dart (registers @client components)
RUN dart run build_runner build --delete-conflicting-outputs

# Build the Jaspr server in release mode
RUN jaspr build

# Diagnostic — confirms binary name and web assets are present after build
RUN echo "=== build/jaspr contents ===" && ls -lh build/jaspr/ && echo "==========================="

# ── Stage 3: Lean runtime image ───────────────────────────────────────────────
FROM debian:bookworm-slim AS runtime

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy compiled server binary + web assets.
# jaspr build outputs to build/jaspr/ relative to the landing package WORKDIR,
# so absolute path in the builder is /build/landing/build/jaspr/.
# jaspr names the binary 'app' (not 'server') — confirmed from serti0x Dockerfile.web.
COPY --from=dart-builder /build/landing/build/jaspr/ ./

# Overlay the Tailwind-generated CSS into the web assets dir
COPY --from=css-builder /build/landing/web/output.css ./web/output.css

# Ensure the binary is executable
RUN chmod +x /app/app

# Railway injects PORT at runtime; jaspr reads JASPR_PORT.
EXPOSE 8080

CMD ["sh", "-c", "JASPR_PORT=${PORT:-8080} ./app"]
