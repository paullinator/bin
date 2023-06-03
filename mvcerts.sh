rsync -av root@$1:/var/lib/caddy/.local/share/caddy/certificates/acme-v02.api.letsencrypt.org-directory/$3 ./
rsync -av $3 root@$2:/var/lib/caddy/.local/share/caddy/certificates/acme-v02.api.letsencrypt.org-directory/
