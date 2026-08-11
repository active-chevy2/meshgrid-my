FROM nginx:alpine

# Bake the site + nginx config into the image so we don't rely on bind mounts.
# (Bind mounts of repo files are unreliable on Coolify — it pre-creates the
# mount source paths as empty directories, which shadows your files and
# breaks nginx.)
RUN rm -f /etc/nginx/conf.d/default.conf
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY html/ /usr/share/nginx/html/

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget -qO- http://127.0.0.1:80/ >/dev/null 2>&1 || exit 1
