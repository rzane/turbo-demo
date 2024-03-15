# Turbo Demo

There are two apps within this project:
* [people.rb](people.rb) - a contact manager built with Turbo Frames
* [todos.rb](todos.rb) - a todo list build with Turbo Streams

The goal of this project is to demonstrate how Turbo _works_, not necessarily to demonstrate best practices. So, I made a few unusual technical decisions:

* This project uses [Sinatra](https://github.com/sinatra/sinatra) and [Sequel](https://github.com/jeremyevans/sequel), rather than Rails, to minimize boilerplate and distractions.
* The views are inlined in the routes. That way, you can see everything that's happening in one place.

### Development

Install dependencies:

    $ bundle install

Start the development server:

    $ bundle exec rerun app.rb


Visit https://localhost:4567

