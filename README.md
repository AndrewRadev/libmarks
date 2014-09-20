## Core idea

Every time I encounter an interesting new library, I bookmark it in a special folder in my browser bookmarks. This doesn't scale very well. It's hard to discover libraries, hard to see which ones have recently updated, and which ones' development has stalled. You can't organize them very well or search them or sort them by different criteria. Technically, with some fooling around, you might be able to, but it could probably be done in a more convenient way.

That's why I started this simple website to act as a better bookmark holder.

Another inspiration was the [The Ruby Toolbox](https://www.ruby-toolbox.com/). It's an excellent resource for popular ruby libraries, categorizing them and showing additional info, but there's no way to bookmark libraries there as personal favorites.

## Setup

To get this working for a development machine, you need a working ruby setup. Having that, it should be enough to:

```
bundle install
bundle exec rake db:migrate
cp config/secrets.yml.example config/secrets.yml
```

To start the server, simply execute:

```
rails server
```

## Stuff to do

In tentative chronological order:

- [ ] Update to rails 4.2, take a look at http://raysrashmi.com/2014/09/02/new-features-in-rails-4-2
- [ ] Fetch library information from github, rubygems (and more places, later on)
- [ ] Users: authentication, per-user bookmarks
- [ ] Design: maybe just a simple bootstrap to begin with. Or a clone of The Ruby Toolbox (or something else)?
- [ ] Categorisation and/or tagging of libraries
- [ ] API access, remote bookmarking, a bookmarklet
- [ ] Dead-simple Android app for bookmarking on the go (using the API)
- [ ] Import a bunch of existing good gems from https://github.com/markets/awesome-ruby
