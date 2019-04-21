# Kanban

That is a plugin to work with user stories in factbox.

## Installation
Add this line to your factbox's Gemfile:

```ruby
gem "kanban", git: "https://github.com/factbox/kanban"
```

If you want use locally:

```ruby
gem 'kanban', path: 'path_to_dir/kanban'
```

So, in factbox root you can:

```bash
$ bundle install
$ rails g install kanban
```

This will create some migrations, so you should run:

```bash
$ rails db:migrate
```
