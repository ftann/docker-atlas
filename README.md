# Atlas

__The Atlas collection provides a set of containers that are configured to work as private cloud.__

Included are a LDAP backend and OIDC provider for SSO and user management.<br/>
Nextcloud for file management and Plex to serve media content.<br/>
Traefik reverse proxy in front of http, tcp and udp services with automatic renewal of certificates.<br/>
Proton-bridge that allows for sending mails to the admin or registered users.

# Requirements

A working server installation is required (preferably fedora due to selinux). The storage locations must be set up
(see `.env` for details).

## Software

- Docker >= 23.0.0
- Docker compose plugin >= 2.17.3
- Firewalld

> The docker compose plugin is required.

## Credentials

- Cloudflare (or other supported providers by traefik)<br/>
  Automatic certificate renewal and dynamic dns require control of a dns zone.
- Protonmail<br/>
  Sending emails via protonmail.

# Installation

It's recommended to create a separate user that has access to docker only. Clone the repository and create a new local
branch. That branch contains all changes to the configuration including usernames and passwords. Commit those changes
and __DO NOT PUSH__ (ofc no permission unless forked).

## User

```shell
useradd -r -U -m -d /atlas -G docker atlas
```

## Repository

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

## Docker

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

## Firewall

Copy the non-standard firewall rules to firewalld's configuration directory. The installation script applies the rules.

```shell
cp atlas/configs/firewall/* /etc/firewalld/services
```

## Settings

1. Adjust the configuration sections where the versions of the container images are set, the domain names, credentials,
   storage locations, timezone, default file permissions and ownership.
    - Database credentials are set up automatically by `./ctl install` (or manually `./scripts/mk-secrets.sh`)
2. Change the configurations in the configs folder
3. Run the installation command of the `ctl` script
   ```shell
   ./ctl install
   ```

# Usage

Run `./ctl` to see the documentation.

```shell
usage: ctl COMMAND

Commands:

install     creates networks and firewall rules, volumes and secrets
up          builds and starts the containers
down        stops the containers
remove      stops and removes the containers and volumes
uninstall   removes unneeded containers, images, networks and volumes
```

## Update

To update the repository first stop the running services. Ensure that all local changes are committed then switch to the
main branch. Fetch all changes from upstream and rebase onto upstream master.

It may be necessary to resolve merge conflicts if extensive changes were made to container configurations.

```shell
git fetch --all --prune # Fetch upstream changes
git rebase -i origin/master # Rebase local changes aka update
```

# Changelog

## 0.20.0

### Removed

* **BREAKING**: inadyn replaced by pfsense
* **BREAKING**: syncthing file synchronisation replaced by nextcloud

## 0.19.0

### Removed

* **BREAKING**: diun, www container images removed
* **BREAKING**: restic container image removed because backup moved to proxmox
* **BREAKING**: udpxy container image removed because of host ns requirement, moved to proxmox

## 0.18.x

### Changed

* Updated container images

## 0.17.0

### Added

* socket-proxy replaces tecnativa/docker-socket-proxy. Uses latest haproxy version, exposes metrics.

## 0.16.5

### Fixed

* Resolved nextcloud warnings X-Robot-Tag, redirects of well-known uris

### Changed

* Updated alpine base images to 3.18.0
* Updated nginx base images to 1.24.0
* Updated chadburn to 1.0.7
* Updated envoy to 1.26.1
* Updated grafana to 9.5.2
* Updated inadyn to 2.11.0
* Updated mariadb to 10.11.3
* Updated nextcloud to 26.0.1
* Updated prometheus to 2.44
* Updated redis to 6.2.12
* Updated syncthing to 1.23.4
* Updated traefik to 2.10.1
* Updated plex to 1.32.1

## 0.16.0

### Changed

* Merged multiple '<<' mapping keys into a single line.
  Docker compose 2.17.3 update go-yaml to v3 which requires this change.

# FAQ

## Permission denied

Ensure that the volumes are owned by the UID and GID defined in `.env`. Make sure that the selinux labels are
correct `./scripts/mk-selinux.sh`.

# Disclaimer

This collection is made to serve my needs. Feel free to adjust to yours.

If you found this repo useful you can always buy me a beer. （ ^_^）o自自o（^_^ ）

[xmr](https://getmonero.org): `473WTZ1gWFdjdEyioCQfbGQKRurZQoPDJLhuFJyubCrk4TRogKCtRum63bFMx2dP2y4AN1vf2fN6La7V7eB2cZ4vNJgMAcG`
