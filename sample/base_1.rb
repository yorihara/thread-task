require "thread/task"

task  =  Task.new do
  sleep  2
  Time.now
end
p task.value

