require 'sinatra'
require_relative 'database'
require_relative 'people'
require_relative 'todos'

get '/' do
  erb <<~HTML
    <h1>Mini Turbo</h1>

    <section>
      <h4>Turbo Frames</h4>
      <p>The People app demonstrates the use of Turbo Frames.</p>
      <a href="/people"><button>Let's go &raquo;</button></a>
    </section>

    <section>
      <h4>Turbo Streams</h4>
      <p>The Todo app demonstrates the use of Turbo Streams.</p>
      <a href="/todos"><button>Let's go &raquo;</button></a>
    </section>
  HTML
end

template :layout do
  <<~HTML
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <title>Mini Turbo</title>
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.min.css" />
      <script type="module" src="https://cdn.skypack.dev/@hotwired/turbo@7"></script>

      <style>
        .flex-between {
          display: flex;
          align-items: center;
          justify-content: space-between;
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
