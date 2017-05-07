require('spec_helper')

describe(Task) do
  describe(".all") do
    it("is empty at first") do
      expect(Task.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a task to the array of saved tasks") do
      test_task = Task.new({:description => "learn SQL", :list_id => 1})
      test_task.save()
      expect(Task.all()).to(eq([test_task]))
    end
  end

  describe("#description") do
    it("let's give you give it a description") do
      test_task = Task.new({:description => "learn SQL", :list_id => 1})
      expect(test_task.description()).to(eq("learn SQL"))
    end
  end

  describe("#list_id") do
    it("lets you read the list ID out") do
      test_task = Task.new({:description => "learn SQL", :list_id => 1})
      expect(test_task.list_id()).to(eq(1))
    end
  end

  describe("#==") do
    it("is the same task if it has the same description") do
      task1 = Task.new({:description => "learn SQL", :list_id => 1})
      task2 = Task.new({:description => "learn SQL", :list_id => 1})
      expect(task1).to(eq(task2))
    end
  end

  describe("#delete") do
    it("deletes a list's tasks from the database") do
      list = List.new({:name => "Epicodus stuff", :id => nil})
      list.save()
      task = Task.new({:description => "learn SQL", :list_id => list.id()})
      task.save()
      task2 = Task.new({:description => "Review Ruby", :list_id => list.id()})
      task2.save()
      list.delete()
      expect(Task.all()).to(eq([]))
    end
  end


end
