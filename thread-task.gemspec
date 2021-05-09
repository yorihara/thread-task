require_relative 'lib/thread/task/version'

Gem::Specification.new do |spec|
  spec.name          = "thread-task"
  spec.version       = Thread::Task::VERSION
  spec.authors       = ["yorihara"]
  spec.email         = ["orihara.yasumi@gmail.com"]

  spec.summary       = %q{ Wrapper library for Thread class for easily describing parallel processing. }
  spec.description   = %q{ Wrapper library of Thread class. Thread::Task, Thrad::Task::Pool }
  spec.homepage      = "https://github.com/yorihara/thread-task/"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
