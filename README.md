[![.github/workflows/integration.yml](https://github.com/redis-stack/homebrew-redis-stack/actions/workflows/integration.yml/badge.svg)](https://github.com/redis-stack/homebrew-redis-stack/actions/workflows/integration.yml)

# redis-stack homebrew

## How do I Redis?

[Learn for free at Redis University](https://university.redis.com/)

[Build faster with the Redis Launchpad](https://launchpad.redis.com/)

[Try the Redis Cloud](https://redis.com/try-free/)

[Dive in developer tutorials](https://developer.redis.com/)

[Join the Redis community](https://redis.com/community/)

[Work at Redis](https://redis.com/company/careers/jobs/)

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
