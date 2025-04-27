if [ ! -d "$HOME/.config/qBittorrent/qBittorrent.conf" ]; then
	echo Setting default config...
	mkdir -p ~/.config/qBittorrent
	mkdir -p /var/logs/qBittorrent
	echo Changing creds...
	PASSWORD_HASH=$(echo -n "${QBITTORRENT_PASSWORD}" | sha1sum | awk '{print $1}')
	cat <<EOF > ~/.config/qBittorrent/qBittorrent.conf
[Application]
FileLogger\Path=/dev/stdout

[BitTorrent]
Session\DefaultSavePath=/Downloads

[Preferences]
WebUI\Password_PBKDF2="@ByteArray(Dmg9acSaXf9jhhNOihXWjg==:yBX9oYePcRSipGUAtDeM38+28erEY4rZMpKqor8Gr99lGWPgAznXPSoGHdV7/PcWqzSDfGcK04kaxLpWRIwp+g==)"

EOF
fi

qbittorrent-nox