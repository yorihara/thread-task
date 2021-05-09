
require "thread/task"

begin
  task  =  Task.new( count: 1 ) do
    sleep  1
    raise  "die now"
  end

  p :wait
  sleep  2

  p :join
  p task.join

  p :done

rescue => e
  p [e.message, e.backtrace.shift]

end

