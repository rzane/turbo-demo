require 'sinatra'
require_relative 'database'
require_relative 'people'
require_relative 'todos'

get '/' do
  erb <<~HTML
    <nav>
      <ul>
        <li><strong>Turbo Demo</strong></li>
        <li><a href="/people">People</a></li>
        <li><a href="/todos">Todo List</a></li>
      </ul>
    </nav>

    <p>Choose a link from above to get started</p>
  HTML
end

template :layout do
  <<~HTML
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <title>Turbo Demo</title>
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@2.0.6/css/pico.min.css" />
      <script type="module" src="https://cdn.jsdelivr.net/npm/@hotwired/turbo@8.0.4/+esm"></script>

      <style>
        .flex-between {
          display: flex;
          align-items: center;
          justify-content: space-between;
        }

        .empty {
          display: none;
        }
        .empty:only-child {
          display: block;
        }
      </style>
    </head>
    <body>
      <main class="container">
        <%= yield %>
      </main>
    </body>
    </html>
  HTML
end
