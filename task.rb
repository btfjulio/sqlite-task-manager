require 'pry'

class Task
  attr_reader :id
  attr_accessor :title, :description, :done

  def initialize(attributes = {})
    @title = attributes[:title]
    @description = attributes[:description]
    @id = attributes[:id]
    @done = attributes[:done] || false
  end

  def self.find(id)
    DB.results_as_hash = true
    result = DB.execute("SELECT * FROM tasks WHERE id = ?", id).first
    Task.new(title: result["title"], description: result["description"],
      done: result["done"], id: result["id"]) if result
  end

  def save
    if @id
      DB.execute("UPDATE tasks SET title = ?, description = ?, done = ? WHERE id = ?", @title, @description, @done, @id)
    else
      DB.execute("INSERT INTO tasks (title, description) VALUES (?, ?)", @title, @description)
      @id = DB.last_insert_row_id
    end
  end

  def self.all
    DB.results_as_hash = true
    results = DB.execute("SELECT * FROM tasks")
    results.map do |result|
      Task.new(title: result["title"], description: result["description"], done: result["done"], id: result["id"])
    end
  end

  def destroy
    DB.execute("DELETE FROM tasks WHERE id = ?", @id)
  end
end




















