# Capistrano::Shell

Opens SSH shell on remote host in current release directory. Requires Capistrano 3.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano-shell'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-shell

## Usage

```ruby
# Capfile
require 'capistrano/shell'
```

```ruby
# config/deploy/production.rb

server 'server1', user: 'deploy', roles: %w{app}
server 'server2', user: 'deploy', roles: %w{db}, no_release: true
```

Then you should be able to do something like this:

    $ cap production -n shell
    $ cap production -n shell ROLES=app
    $ cap production -n shell HOSTS=server1
    $ cap production -n shell HOSTS=server2

When connecting to `server1` ssh will cd into `/var/www/your_app/current` directory(`release_path`). But when connecting to `server2` just `/home/deploy` will be opened because `server2` is marked as `no_release`.

In the last two example the `HOSTS` environment variable is used. However, you probably don't need to use it because `capistrano/shell` asks you what server to use when there are many.

## Contributing

1. Fork it ( https://github.com/marshall-lee/capistrano-shell/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
