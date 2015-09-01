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

* Create and get Client ID and Client Secret from [Slack Authentication page](https://api.slack.com/docs/oauth)
  (do not forget to set the redirect URL to `https://localhost:3000/auth/slack/callback`)

* Get the Team ID from [Slack auth test page](https://api.slack.com/methods/auth.test/test)

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
