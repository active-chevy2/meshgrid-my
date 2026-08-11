# MeshGrid MY

Ultra-lightweight, bilingual (English + Bahasa Melayu) single-page site for
coordinating decentralized mesh networks (BitChat & Meshtastic) across
Malaysia. Pure static HTML/CSS/JS — no build step, loads instantly on old
smartphones and low-bandwidth links.

## Run in browser

Just open `html/index.html` in a browser.

## Run with Docker Compose (local)

```bash
docker compose up -d --build
# for local port testing:
docker compose run --service-ports --rm web
```

Stop:
```bash
docker compose down
```

## Deploy on Coolify

Coolify runs a built-in reverse proxy that routes your domain to the
container's internal port. Two important rules for this app:

- **Do not publish host ports** — that causes
  `Bind for 0.0.0.0:8080 failed: port is already allocated`. This compose
  uses `expose: 80` instead.
- **Do not bind-mount repo files** — Coolify pre-creates bind-mount source
  paths as empty directories, which makes nginx fail with
  `pread() ".../default.conf" failed (21: Is a directory)`. Instead the site
  and nginx config are baked into the image via the `Dockerfile`.

Steps:

1. Create a new resource → **Docker Compose** → point it at this repo.
2. Set your **Domain (FQDN)** in the resource settings (Coolify wires up the
   proxy from this).
3. Deploy. Coolify builds the image from the `Dockerfile` and routes your
   domain to port `80` inside the container.

If an old container is still holding a port on the server, remove it first
(`docker ps` → `docker rm -f <old_container>`) before redeploying.

See `COOLIFY_NOTES.md` for the full error map.

## Files

- `docker-compose.yaml` — Docker Compose service definition (no `ports:`, no `volumes:`)
- `Dockerfile` — builds the nginx image with the site + config baked in
- `nginx/default.conf` — nginx config (gzip, security headers, cache, 404)
- `html/index.html` — the entire self-contained page (embedded CSS + JS)
- `html/404.html` — themed 404 page
- `COOLIFY_NOTES.md` — deployment troubleshooting notes
