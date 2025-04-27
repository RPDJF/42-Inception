chown qbuser:qbuser /qBittorrent -R || true
exec su qbuser -c "qbittorrent-nox --profile=/"