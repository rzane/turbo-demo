require "sequel"

Database = Sequel.sqlite

Database.create_table :people do
  primary_key :id
  column :name, :string
  column :email, :string
  column :birthday, :date
end

Database.create_table :todos do
  primary_key :id
  column :label, :string
  column :completed_at, :datetime
end

class Person < Sequel::Model
end

class Todo < Sequel::Model
end

Person.insert(name: "Rick Flare", email: "rf@example.org", birthday: Date.new(1949, 2, 25))
Person.insert(name: "O.T. Genasis", email: "ot@example.org", birthday: Date.new(1987, 6, 18))

Todo.insert(label: "Walk the dog")
Todo.insert(label: "Mow the lawn")
