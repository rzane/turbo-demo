require 'sinatra'
require_relative 'database'

get '/' do
  @people = Person.all

  erb <<~HTML
    <nav>
      <ul>
        <li><strong>People</strong></li>
      </ul>
      <ul>
        <li>
          <a href="/people/new" data-turbo-frame="modal">
            <button>Add Person</button>
          </a>
        </li>
      </ul>
    </nav>

    <% @people.each do |person| %>
      <turbo-frame id="person_<%= person.id %>">
        <article class="flex-between">
          <%= person.name %>
          <div>
            <a href="/people/<%= person.id %>">View</a>
            <a href="/people/<%= person.id %>/edit" data-turbo-frame="modal">Edit</a>
          </div>
        </article>
      </turbo-frame>
    <% end %>

    <turbo-frame id="modal"></turbo-frame>
  HTML
end

get '/people/new' do
  locals = {
    person: Person.new,
    action: "/people",
    method: "post",
    title: "Add Person"
  }

  erb :form, layout: false, locals:
end

post '/people' do
  person = Person.new(params[:person])
  person.save
  redirect '/'
end

get '/people/:id' do
  @person = Person.with_pk!(params[:id])

  erb <<~HTML, layout: false
    <turbo-frame id="person_<%= @person.id %>">
      <article>
        <header><%= @person.name %></header>
        <dl>
          <dt>Name</dt>
          <dd><%= @person.name %></dd>
          <dt>Email</dt>
          <dd><%= @person.email %></dd>
          <dt>Birthday</dt>
          <dd><%= @person.birthday %></dd>
        </dl>
        <footer>
          <a href="/">Back</a>
        </footer>
      </article>
    </turbo-frame>
  HTML
end

get '/people/:id/edit' do
  person = Person.with_pk!(params[:id])

  locals = {
    person:,
    action: "/people/#{person.id}",
    method: "put",
    title: "Edit Person"
  }

  erb :form, layout: false, locals:
end

put '/people/:id' do
  @person = Person.with_pk!(params[:id])
  @person.update(params[:person])
  redirect '/'
end

template :form do
  <<~HTML
    <turbo-frame id="modal">
      <dialog open>
        <form action="<%= action %>" method="<%= method %>" data-turbo-frame="_top">
          <article>
            <header>
              <p><strong><%= title %></strong></p>
            </header>

            <label>
              Name
              <input type="text" name="person[name]" value="<%= person.name %>" />
            </label>
            <label>
              Email
              <input type="email" name="person[email]" value="<%= person.email %>" />
            </label>
            <label>
              Birthday
              <input type="date" name="person[birthday]" value="<%= person.birthday %>" />
            </label>

            <footer>
              <button>Save</button>
              <button formmethod="dialog" class="outline">Cancel</button>
            </footer>
          </article>
        </form>
      </dialog>
    </turbo-frame>
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
