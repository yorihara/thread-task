require "thread/task"

ident = "foobar"

tasks1 = (1...4).map do |i|
  sleep  0.1
  Task.once( i, guard:3, ident: ident ) do |j|
    p j
  end
end
tasks2 = (4...8).map do |i|
  sleep  0.1
  Task.once( i, guard:3, ident: ident ) do |j|
    p j
  end
end

tasks1.each(&:join)
tasks2.each(&:join)

