# Ennigaldi

https://collections.museumvictoria.com.au/developers

- Articles
- Items
- Images
- Species
- Specimens

http://help.nla.gov.au/trove/building-with-trove/api
http://help.nla.gov.au/trove/building-with-trove/api-technical-guide
http://help.nla.gov.au/trove/experiments

## Setup

How to run tests:

```
% bundle exec rake
```

How to run the development console:

```
% bundle exec hanami console
```

How to run the development server:

```
% bundle exec hanami server
```

How to prepare (create and migrate) DB for `development` and `test` environments:

```
% bundle exec hanami db prepare

% HANAMI_ENV=test bundle exec hanami db prepare
```

Explore Hanami [guides](http://hanamirb.org/guides/), [API docs](http://docs.hanamirb.org/1.2.0/), or jump in [chat](http://chat.hanamirb.org) for help. Enjoy! 🌸
