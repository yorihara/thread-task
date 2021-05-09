
RSpec.describe Thread::Task::Pool do

  it "Task.new  time order 2" do
    tasks  =  (0...10).map do |i|
      Task.new( i, count: 3 ) do |j|
        expect( i ).to be == j
        sleep( rand * 2 )
        time  =  Time.now
      end
    end
    time1  =  Time.now
    times  =  tasks.map(&:value)
    time2  =  Time.now
    times.each do |time|
      expect( time ).to be >= time1
      expect( time ).to be <= time2
    end
  end

end
