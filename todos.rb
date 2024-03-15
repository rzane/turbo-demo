get '/todos' do
  @completed, @pending = Todo.all.partition(&:completed_at)

  erb <<~HTML
    <section>
      <nav>
        <ul>
          <li><strong>Turbo Demo</strong></li>
          <li><a href="/people">People</a></li>
          <li>Todo List</li>
        </ul>
      </nav>
    </section>

    <h4>Add a todo</h4>
    <section id="form">
      <%= erb :todo_form %>
    </section>

    <h4>Pending</h4>
    <section id="pending">
      <% @pending.each do |todo| %>
        <%= erb :todo, locals: { todo: } %>
      <% end %>

      <div class="empty">You've completed all of your tasks!</div>
    </section>

    <h4>Completed</h4>
    <section id="completed">
      <% @completed.each do |todo| %>
        <%= erb :todo, locals: { todo: } %>
      <% end %>

      <div class="empty">You haven't completed any tasks.</div>
    </section>

    <script type="module">
      import autoAnimate from 'https://cdn.jsdelivr.net/npm/@formkit/auto-animate@0.8.1/+esm';
      autoAnimate(document.getElementById('pending'));
      autoAnimate(document.getElementById('completed'));
    </script>
  HTML
end

post '/todos' do
  @todo = Todo.new(params[:todo])
  @todo.save

  headers['content-type'] = 'text/vnd.turbo-stream.html'

  erb <<~HTML, layout: false
    <turbo-stream action="update" target="form">
      <template><%= erb :todo_form %></template>
    </turbo-stream>
    <turbo-stream action="prepend" target="pending">
      <template><%= erb :todo, locals: { todo: @todo } %></template>
    </turbo-stream>
  HTML
end

delete '/todos/:id' do
  @todo = Todo.with_pk!(params[:id])
  @todo.completed_at = Time.now
  @todo.save

  headers['content-type'] = 'text/vnd.turbo-stream.html'

  erb <<~HTML, layout: false
    <turbo-stream action="remove" target="todo_<%= @todo.id %>"></turbo-stream>
    <turbo-stream action="prepend" target="completed">
      <template><%= erb :todo, locals: { todo: @todo } %></template>
    </turbo-stream>
  HTML
end

template :todo do
  <<~HTML
    <article id="todo_<%= todo.id %>" class="flex-between">
      <% if todo.completed_at %>
        <del><%= todo.label %></del>
        <div><%= todo.completed_at.strftime('%b %e, %l:%M %p') %></div>
      <% else %>
        <div><%= todo.label %></div>
        <form method="delete" action="/todos/<%= todo.id %>">
          <button>Done</button>
        </form>
      <% end %>
    </article>
  HTML
end

template :todo_form do
  <<~HTML
    <form method="post" action="/todos">
      <fieldset role="group">
        <input name="todo[label]" type="text" placeholder="Enter a todo..." />
        <input type="submit" value="Add" />
      </fieldset>
    </form>
  HTML
end
