require "monitor"

class ::Thread
  class Task

    class Pool
      attr_reader  :rest

      def initialize( size )
        @rest  =  size
        @monitor  =  Monitor.new
        @lock_cond  =  @monitor.new_cond
      end

      def acquire
        @monitor.synchronize do
          @lock_cond.wait_while{ @rest == 0 }
          @rest  -=  1
        end
      end

      def release
        @monitor.synchronize do
          @rest  +=  1
          @lock_cond.signal
        end
      end
    end

    @@pool = ::Hash.new

    def initialize( *args, pool: nil, count: nil, report_on_exception: false, &block )
      raise  ::ArgumentError, "block required."    if block.nil?

      if  pool.nil? and count.nil?
        @thread  =  ::Thread.start( args ) do |args_|
          ::Thread.current.report_on_exception  =  report_on_exception
          block.call( *args_ )
        end

      elsif  pool  and pool.is_a?(::Thread::Task::Pool)
        @thread  =  ::Thread.start( args ) do |args_|
          ::Thread.current.report_on_exception  =  report_on_exception
          pool.acquire
          begin
            block.call( *args_ )
          ensure
            pool.release
          end
        end

      elsif  count  and  count.is_a? ::Integer  and  count > 0
        key  =  caller[1]
        unless ( pool = @@pool[key] )
          pool  =  ::Thread::Task::Pool.new( count )
          @@pool[key]  =  pool
        end

        @thread  =  ::Thread.start( args ) do |args_|
          ::Thread.current.report_on_exception  =  report_on_exception
          pool.acquire
          begin
            block.call( *args_ )
          ensure
            pool.release
          end
        end

      else
        raise  ::ArgumentError, "Nil or size of Thread::Task::Pool object expected."

      end
    end

    def join
      @thread.join
    end

    def value
      @thread.value
    end

    def cancel
      @thread.kill
      nil
    end

    class Counter
      def initialize
        @count  =  0
        @mutex  =  Mutex.new
      end

      def incr
        @mutex.synchronize do
          @count  +=  1
        end
      end

      def decr
        @mutex.synchronize do
          @count  -=  1    if  @count > 0
          @count
        end
      end

      def reset
        @mutex.synchronize do
          @count  =  0
        end
      end
    end

    @@counter = ::Hash.new{|h,k| h[k] = Counter.new }

    def Task.once( *args, delay: nil, guard: nil, ident: nil, &block )
      key  =  ( ident || caller[0] ).to_s
      if  delay  and  delay.is_a? ::Numeric  and  delay > 0
        @@counter[key].incr
        ::Thread::Task.new( key ) do |key_|
          ::Kernel.sleep  delay
          count  =  @@counter[key_].decr
          block.call( *args )    if count == 0
        end
      elsif  guard  and  guard.is_a? ::Numeric  and  guard > 0
        count  =  @@counter[key].incr
        block.call( *args )    if count == 1
        ::Thread::Task.new( key ) do |key_|
          ::Kernel.sleep  guard
          @@counter[key_].decr
        end
      else
        raise  ::ArgumentError, "delay or guard time expected."
      end
    end

  end
end

