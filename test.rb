require "sqlite3"
DB = SQLite3::Database.new("tasks.db")
DB.results_as_hash = true
require_relative "task"

# Read one with id
task = Task.find(4)
puts "Hoje voce vai #{task.title} #{task.description}"

# Create one task
# title = "Beber"
# description = "até cair"
# task = Task.new(title: title, description: description)
# task.save
# puts "Hoje voce vai #{task.title} #{task.description}"


# Read all
tasks = Task.all
tasks.each do |task|
  puts "#{task.done != 0 ? '[X]' : '[ ]'} - #{task.title}"
end

# UPDATE
task = Task.find(4)
task.title = "Estudar"
task.save
puts Task.find(4).title == "Estudar"


# DELETE
task = Task.find(4)
task.destroy

puts Task.find(4) == nil




