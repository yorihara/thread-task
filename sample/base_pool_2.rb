require "thread/task"

pool  =  Task::Pool.new( 3 )

tasks1  =  (0...4).map do |i|
  Task.new( i, pool: pool ) do |j|
    p [" ->", j]
    sleep(rand*2)
    p ["<- ", j]
  end
end
tasks2  =  (4...8).map do |i|
  Task.new( i, pool: pool ) do |j|
    p [" ->", j]
    sleep(rand*2)
    p ["<- ", j]
  end
end

tasks1.each(&:join)
tasks2.each(&:join)

