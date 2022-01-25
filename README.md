# Atlas

__The Atlas collection provides a collection of containers that are configured to work as private cloud.__

Included are a LDAP backend and OIDC provider for SSO and user management.<br/>
Nextcloud for file management, Syncthing as file synchronization service and Plex to serve media content.<br/>
Nginx proxy in front of web services with automatic renewal of certificates.<br/>
Proton-bridge that allows for sending mails to the admin or registered users.

Automatic update of the running containers and automatic backup of both the container state and the data.

An instance of Udpxy runs to convert multicast iptv signals to unicast.

## Requirements

A working server installation is required (preferably fedora due to selinux). The storage locations must be set up
(see `.env` for details).

### Software

- Docker
- Docker-compose
- Firewalld

### Credentials

- Backblaze<br/>
  To back up the whole server a Backblaze account is required.
- Cloudflare<br/>
  Automatic certificate renewal and dynamic dns require control of a dns zone.
- Maxmind<br/>
  Allows geo-blocking in the web proxy.
- Protonmail<br/>
  Sending emails via protonmail.

## Installation

### Docker

Configure docker to allow ipv6 addresses. Set the following keys in the docker configuration `/etc/docker/daemon.json`:

```json
{
  "experimental": true,
  "ipv6": true,
  "ip6tables": true,
  "fixed-cidr-v6": "fd00:d0ce:1::/64"
}
```

Make sure that the used network in `fixed-cidr-v6` matches the range used in `./scripts/mk-networks.sh`.

### Settings

1. Adjust the configuration sections where the versions of the conainer images are set, the domain names, credentials,
   storage locations, timezone, default file permissions and ownership.
    - Database credentials are setup automatically by `./ctl install` (or manually `./scripts/mk-secrets.sh`)
    - The proton-bridge mailbox password must be read from the stdout when the proton-bridge container starts
      for the first time.

3. Run the installation command of the `ctl` script
    ```shell
    ./ctl install
    ```

## Usage

Run `./ctl` to see the documentation.

```shell
usage: ctl COMMAND

Commands:

install     creates networks and firewall rules, volumes and secrets
up          builds and starts the containers
down        stops the containers
remove      stops and removes the containers and volumes
clean       removes unneeded containers, images, networks and volumes
status      displays current container status
```

## FAQ

### Permission denied

Ensure that the volumes are owned by the UID and GID defined in `.env`. Make sure that the selinux labels are
correct `./scripts/mk-selinux.sh`.

## Disclaimer

This collection serves my purposes only. Feel free to adjust to your needs. If you found this repo useful you can always
buy me a beer. （ ^_^）o自自o（^_^ ）

[xmr](https://getmonero.org): `473WTZ1gWFdjdEyioCQfbGQKRurZQoPDJLhuFJyubCrk4TRogKCtRum63bFMx2dP2y4AN1vf2fN6La7V7eB2cZ4vNJgMAcG`
