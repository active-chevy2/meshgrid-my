# Coolify deployment notes for MeshGrid MY

Short lessons from real trial and error. Simple English.

## 1. Do NOT publish host ports

Coolify has its own reverse proxy. It sends your domain to the container port.
If you publish a host port, you get:

```
Bind for 0.0.0.0:8080 failed: port is already allocated
```

**Bad**
```yaml
ports:
  - "8080:80"
```

**Good**
```yaml
expose:
  - "80"
```

Then set your **Domain (FQDN)** in the Coolify resource settings.
Coolify routes the domain to the exposed port for you.

## 2. Do NOT bind-mount repo files

Coolify pre-creates bind-mount source paths as empty folders in its own
storage, so your config file becomes an empty folder and the app breaks.
Example nginx error:

```
nginx: [crit] pread() ".../default.conf" failed (21: Is a directory)
```

**Bad**
```yaml
volumes:
  - ./nginx:/etc/nginx/conf.d
  - ./html:/usr/share/nginx/html
```

**Good** — bake files into the image with a `Dockerfile`:
```dockerfile
FROM nginx:alpine
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY html/ /usr/share/nginx/html/
EXPOSE 80
```
```yaml
services:
  web:
    build: .
    expose:
      - "80"
```

## 3. Old container holds the port

If a past deploy left a container running, it may keep the port.
On the server:

```bash
docker ps
docker rm -f <old_container_name>
```

Then redeploy.

## 4. Deploy checklist

- [ ] Use `build:` + `Dockerfile` (no bind mounts for config/site files)
- [ ] Use `expose:`, not `ports:`
- [ ] Set the Domain (FQDN) in Coolify
- [ ] Remove any old/stuck container
- [ ] Redeploy and read the logs

## 5. Quick error map

| Log message | Cause | Fix |
|---|---|---|
| `port is already allocated` | Published a host port | Use `expose:` + set domain |
| `pread() ... failed (21: Is a directory)` | Bind-mounted a file | Bake files into image via Dockerfile |
| "no available servers" in UI / restarting x8 | Container crash-loops | Check container logs, fix the real error above |
