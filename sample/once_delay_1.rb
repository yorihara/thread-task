require "thread/task"

tasks = (1...8).map do |i|
  sleep  0.1
  Task.once( i, delay:3 ) do |j|
    p j
  end
end

tasks.each(&:join)
