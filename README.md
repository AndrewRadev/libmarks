## Core idea

Every time I encounter an interesting new library, I bookmark it in a special folder in my browser bookmarks. This doesn't scale very well. It's hard to discover libraries, hard to see which ones have recently updated, and which ones' development has stalled. You can't organize them very well or search them or sort them by different criteria. Technically, with some fooling around, you might be able to, but it could probably be done in a more convenient way.

That's why I started this simple website to act as a better bookmark holder for programming libraries.

Another inspiration was the [The Ruby Toolbox](https://www.ruby-toolbox.com/). It's an excellent resource for popular ruby libraries, categorizing them and showing additional info, but there's no way to bookmark libraries there as personal favorites.

## Setup

To get this working for a development machine, you need a working ruby setup. Having that, it should be enough to run:

```
bin/setup
```

In order to get user authentication working, you'll need to set up social network keys in `secrets.yml`:

``` yaml
development:
  facebook_key:    <%= ENV["LIBMARKS_FACEBOOK_KEY"] %>
  facebook_secret: <%= ENV["LIBMARKS_FACEBOOK_SECRET"] %>
  twitter_key:     <%= ENV["LIBMARKS_TWITTER_KEY"] %>
  twitter_secret:  <%= ENV["LIBMARKS_TWITTER_SECRET"] %>
  github_key:      <%= ENV["LIBMARKS_GITHUB_KEY"] %>
  github_secret:   <%= ENV["LIBMARKS_GITHUB_SECRET"] %>
```

Creating the relevant apps and putting the environment keys in your `.bashrc` or `.zshrc` should be enough.

To start the server, simply execute:

```
rails server
```

## Production setup

Right now, the app is not meant to be used in production on anything other than my own host, [libmarks.andrewradev.com](http://libmarks.andrewradev.com). If you want to get it running somewhere else, you'd have to tweak the capistrano recipes, and possibly other stuff.

If you'd like help in setting it up for this purpose, open an issue in the bug tracker and I'll try to make it easier to configure.

## Inspiration

- The Ruby Toolbox: [https://www.ruby-toolbox.com/](https://www.ruby-toolbox.com/)
- Astral:           [http://astralapp.com](http://astralapp.com)

## Stuff to do

In tentative chronological order:

- [x] Update to rails 4.2, take a look at http://raysrashmi.com/2014/09/02/new-features-in-rails-4-2
- [x] Fetch library information from github, rubygems (and more places, later on)
- [x] Migrate to postgresql
- [x] Users: authentication, per-user bookmarks
- [x] Design: maybe just a simple bootstrap to begin with. Or a clone of The Ruby Toolbox (or something else)?
- [x] Batch adding of bookmarks
- [x] Categorisation and/or tagging of libraries
- [x] Fetch info via background job
- [x] Info on the /pages/login page
- [x] Exception notifications
- [x] Better tag input mechanism with completion
- [x] Better layout for links, showing just project name, (repo name), tags, link to details
- [ ] Pagination
- [ ] Language logo and source logo (github)
- [ ] Filter by tags/language
- [ ] Rate limiting on github info fetching
- [ ] Rubygems urls support
- [ ] jQuery plugin urls support: http://plugins.jquery.com/
- [ ] Create global bookmarks, visible to anyone, from user ones
- [ ] Unify/link bookmarks -- simple duplicates, forks, homepage/rubygems/github/blog post
- [ ] Import a bunch of existing good gems from https://github.com/markets/awesome-ruby
- [ ] Auto-import github stars if you've connected your github account
- [ ] API access, remote bookmarking, a bookmarklet
- [ ] Dead-simple Android app for bookmarking on the go (using the API)
- [ ] Overall styling refactoring, compass/bourbon, own all style in the project
