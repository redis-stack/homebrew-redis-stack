[![.github/workflows/integration.yml](https://github.com/redis-stack/homebrew-redis-stack/actions/workflows/integration.yml/badge.svg)](https://github.com/redis-stack/homebrew-redis-stack/actions/workflows/integration.yml)

# redis-stack homebrew

## Installation

Enable the repostiory:

```
brew tap redis-stack/redis-stack
```

Install redis-stack

```
brew install --cask redis-stack
```

## Upgrading

To upgrade redis-stack server:

```
brew upgrade redis-stack-server
```

To upgrade redisinsight:

```
brew upgrade redis-stack-redisinsight
```

By default redis-stack will have no password, Redis Stack supports the ability to configure multiple named users, each with their own password and access control configuration.  Refer to the [Redis Access Control List documentation](https://redis.io/docs/management/security/acl/) for more information. Alternatively the configuration file can be edited and the *requirepass* directive added.
