
RSpec.describe Thread::Task do

  it "Task.new  time order 1" do
    time1  =  Time.now
    time2  =  nil
    time3  =  nil
    time4  =  nil

    task  =  Task.new do
      sleep  1
      time3  =  Time.now
    end

    time2  =  Time.now
    time4  =  task.value

    expect( time1 ).to be <= time2
    expect( time2 ).to be <= time3
    expect( time3 ).to be == time4
  end

end
