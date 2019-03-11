# UserStories

This is a boilerplate to create new plugins.
FactBox basically is extended by new Artifact models. To keep one modular ecosystem, it's recomended insert those artifacts via plugin.

# Usage

TODO

## Installation
Add this line to your factbox's Gemfile:

```ruby
gem "PLUGIN_NAME", git: "PLUGIN_GIT_URL"
```

If you want use locally:

```ruby
gem 'user_stories', path: '/home/pwener/Workspace/user_stories'
```

So, in factbox root you can:

```bash
$ rails g install PLUGIN_NAME
```

This will create some migrations, so you should run:

```bash
$ rails db:migrate
```
