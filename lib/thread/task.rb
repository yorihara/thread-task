require "thread/task/version"
require "thread/task/base"

::Task = ::Thread::Task  unless defined?(::Task)

