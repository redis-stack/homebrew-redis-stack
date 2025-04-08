[![.github/workflows/integration.yml](https://github.com/redis-stack/homebrew-redis-stack/actions/workflows/integration.yml/badge.svg)](https://github.com/redis-stack/homebrew-redis-stack/actions/workflows/integration.yml)

# Homebrew Tap for redis-stack

## Quick Installation

To enable the tap and install Redis Stack server and RedisInsight:

```sh
brew tap redis-stack/redis-stack
brew install --cask redis-stack
```

To start a background service for `redis-stack-server` so that it starts in the background now and on login:

```sh
brew services start redis-stack-service
```

## Configuration

By default redis-stack will have no password, Redis Stack supports the ability to configure multiple named users, each with their own password and access control configuration. Refer to the [Redis Access Control List documentation](https://redis.io/docs/management/security/acl/) for more information. Alternatively the configuration file can be edited and the *requirepass* directive added.

## Manual Installation

If you only want to install certain components, first enable the tap:

```sh
brew tap redis-stack/redis-stack
```

### Install redis-stack-server (Cask)

```sh
brew install --cask redis-stack-server
```

### Install redis-stack-redisinsight (Cask)

```sh
brew install --cask redis-stack-redisinsight
```

### Service support for redis-stack-server (Formula)

To run redis-stack-server as a service, install the formula:

```sh
brew install redis-stack-service
brew services start redis-stack-service
```

## Upgrading

To upgrade the components:

```sh
brew upgrade --cask redis-stack-server
brew upgrade --cask redis-stack-redisinsight
```

## Uninstalling

You must uninstall each component separately:

```sh
brew uninstall --cask redis-stack
brew uninstall --cask redis-stack-server
brew uninstall --cask redis-stack-redisinsight
brew uninstall redis-stack-service
```

You may then remove the tap:

```sh
brew untap redis-stack/redis-stack
```
