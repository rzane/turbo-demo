require 'sinatra'

get '/' do
  erb 'Hello world'
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
    </head>
    <body>
      <main class="container">
        <nav>
          <ul>
            <li><strong>Mini Turbo</strong></li>
          </ul>
        </nav>

        <%= yield %>
      </main>
    </body>
    </html>
  HTML
end
