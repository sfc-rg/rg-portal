RG Portal
=====

## Development Environment Configuration

### Requirements

* Ruby 2.2.1
* Bundler

### Recommends

* rbenv

### Slack OAuth configuration file

* Copy configuration sample from `config/oauth.yml.sample`

```
$ cp config/oauth.yml.sample config/oauth.yml
```
* Get the oauth information from [Slack RG AuthenticationのOAuth情報](http://portal.gw.sfc.wide.ad.jp/pages/service/portal/oauth) (require slack authentication)

* Do not create a new authentication yourself. The number of integrations has a limit.

### Library installation

```
$ bundle install --path=vendor/bundle
```

If you have a error like `Failed to build gem native extension.` during installation of `libv8` or `therubyracer`, following configurations may help you.

```
$ bundle config build.libv8 --with-system-v8
$ bundle config build.therubyracer --with-v8-dir
```

### Database creation

```
$ bundle exec rake db:migrate RAILS_ENV=development
```

It will create database file like `db/development.sqlite3`
