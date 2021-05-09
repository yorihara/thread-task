require "thread/task"

tasks  =  (0...8).map do |i|
  Task.new( i, count:3 ) do |j|
    p [" ->", j]
    sleep  rand*2
    p ["<- ", j]
  end
end

tasks.each(&:join)

