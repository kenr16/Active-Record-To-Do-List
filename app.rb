require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('lib/**/*.rb')
require('./lib/task')
require('./lib/list')
require('pg')
require('pry')

get('/') do
  @lists = List.all
  @tasks = Task.all
  erb(:index)
end

get('/lists/new') do
  erb(:list_form)
end

post('/lists') do
  name = params.fetch("name")
  @list = List.new({:name => name, :id => nil})
  if @list.save()
    erb(:success)
  else
    erb(:list_errors)
  end
end

get('/lists') do
  @lists = List.all
  erb(:lists)
end

get("/lists/:id") do
  @list = List.find(params.fetch("id").to_i())
  erb(:list)
end

post("/tasks") do
  description = params.fetch("description")
  @task = Task.new({:description => description, :done => false})
  if @task.save()
    erb(:success)
  else
    erb(:errors)
  end
end

get("/lists/:id/edit") do
  @list = List.find(params.fetch("id").to_i())
  erb(:list_edit)
end

patch("/lists/:id") do
  name = params.fetch("name")
  @list = List.find(params.fetch("id").to_i())
  @list.update({:name => name})
  erb(:list)
end

delete("/lists/:id") do
  @list = List.find(params.fetch("id").to_i())
  @list.delete()
  @lists = List.all()
  erb(:index)
end

get('/tasks/:id') do
  @task = Task.find(params.fetch("id").to_i())
  @lists = List.all()
  erb(:task_edit)
end
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

patch("/tasks/:id") do
  description = params.fetch("description")
  @task = Task.find(params.fetch("id").to_i())
  binding.pry
  @task.update({:description => description})
  @tasks = Task.all()
  erb(:index)
end


post("/add_lists/:id") do
  list_id = params.fetch("list_id")
  @list = List.find(list_id.to_i())
  @task = Task.find(params.fetch("id").to_i())
  @list.tasks().new({:description => @task.description()})
  @list.save()
  @lists = List.all
  @tasks = Task.all
  erb(:index)
end
