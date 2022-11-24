# Atlas

__The Atlas collection provides a set of containers that are configured to work as private cloud.__

Included are a LDAP backend and OIDC provider for SSO and user management.<br/>
Nextcloud for file management, Syncthing as file synchronization service and Plex to serve media content.<br/>
Traefik reverse proxy in front of http, tcp and udp services with automatic renewal of certificates.<br/>
Proton-bridge that allows for sending mails to the admin or registered users.

Automatic update of the running containers and automatic backup of both the container state and the data.

An instance of Udpxy runs to convert multicast iptv signals to unicast.

## Requirements

A working server installation is required (preferably fedora due to selinux). The storage locations must be set up
(see `.env` for details).

### Software

- Docker
- Docker compose plugin >= 2
- Firewalld

> The docker compose plugins is required.

### Credentials

- Backblaze<br/>
  To back up the whole server a Backblaze account is required.
- Cloudflare (or other supported providers by traefik)<br/>
  Automatic certificate renewal and dynamic dns require control of a dns zone.
- Protonmail<br/>
  Sending emails via protonmail.

## Installation

It's recommended to create a separate user that has access to docker only. Clone the repository and create a new local
branch. That branch contains all changes to the configuration including usernames and passwords. Commit those changes
and __DO NOT PUSH__ (ofc no permission unless forked).

### User

```shell
useradd -r -U -m -d /atlas -G docker atlas
```

### Repository

```shell
sudo su atlas # login as atlas user
cd # ensure working dir is the user home
git clone git@github.com:ftann/docker-atlas.git atlas # clone
cd atlas
git switch -c config # create new branch
# Add secrets and other configs.
git add . # add changes
git commit -m "config" # commit changes
```

### Docker

Configure docker to allow ipv6 addresses. Set the following keys in the docker configuration `/etc/docker/daemon.json`:

```json
{
  "log-driver": "journald",
  "experimental": true,
  "ipv6": true,
  "ip6tables": true,
  "fixed-cidr-v6": "fd00:d0ce::/64",
  "metrics-addr": "0.0.0.0:9323",
  "userland-proxy": false
}
```

Make sure that the used network in `fixed-cidr-v6` matches the range used for ipv6 subnets.

### Firewall

Copy the non-standard firewall rules to firewalld's configuration directory. The installation script applies the rules.

```shell
cp atlas/configs/firewall/* /etc/firewalld/services
```

### Settings

1. Adjust the configuration sections where the versions of the container images are set, the domain names, credentials,
   storage locations, timezone, default file permissions and ownership.
    - Database credentials are set up automatically by `./ctl install` (or manually `./scripts/mk-secrets.sh`)
    - The proton-bridge mailbox password must be read from the stdout when the proton-bridge container starts for the
      first time.
2. Change the configuration in the volume init container
    - `./images/init` Configure the authelia, envoy, ldap, prometheus, traefik settings
    - `./images/www` Add a default landing page
3. Run the installation command of the `ctl` script
   ```shell
   ./ctl install
   ```
4. Find the proton-bridge mailbox password. Look for the generated password for the provided user. Copy to `.env`.
   ```shell
   docker logs proton-bridge
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
uninstall   removes unneeded containers, images, networks and volumes
status      displays current container status
```

### Update

To update the repository first stop the running services. Ensure that all local changes are committed then switch to the
main branch. Fetch all changes from upstream and rebase onto upstream master.

It may be necessary to resolve merge conflicts if extensive changes were made to container configurations.

```shell
git fetch --all --prune # Fetch upstream changes
git rebase -i origin/master # Rebase local changes aka update
```

## FAQ

### Permission denied

Ensure that the volumes are owned by the UID and GID defined in `.env`. Make sure that the selinux labels are
correct `./scripts/mk-selinux.sh`.

## Disclaimer

This collection is made to serve my needs. Feel free to adjust to yours.

If you found this repo useful you can always buy me a beer. （ ^_^）o自自o（^_^ ）

[xmr](https://getmonero.org): `473WTZ1gWFdjdEyioCQfbGQKRurZQoPDJLhuFJyubCrk4TRogKCtRum63bFMx2dP2y4AN1vf2fN6La7V7eB2cZ4vNJgMAcG`
