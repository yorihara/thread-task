
RSpec.describe Thread::Task do

  it "Task.once  delay:3 #1" do
    tasks = (1..8).map do |i|
      sleep  0.1
      Task.once( i, delay:3 ) do |j|
        expect( j ).to be == 8
      end
    end
    tasks.each(&:join)
  end

  it "Task.once  delay:3 #2" do
    ident = "foobar"

    tasks1 = (1..4).map do |i|
      sleep  0.1
      Task.once( i, delay:3, ident: ident ) do |j|
        expect( j ).to be == 8
      end
    end
    tasks2 = (5..8).map do |i|
      sleep  0.1
      Task.once( i, delay:3, ident: ident ) do |j|
        expect( j ).to be == 8
      end
    end

    tasks1.each(&:join)
    tasks2.each(&:join)
  end

  it "Task.once  guard:3 #1" do
    tasks = (1..8).map do |i|
      sleep  0.1
      Task.once( i, guard:3 ) do |j|
        expect( j ).to be == 1
      end
    end
    tasks.each(&:join)
  end

  it "Task.once  guard:3 #2" do
    ident = "foobar"

    tasks1 = (1..4).map do |i|
      sleep  0.1
      Task.once( i, guard:3, ident: ident ) do |j|
        expect( j ).to be == 1
      end
    end
    tasks2 = (5..8).map do |i|
      sleep  0.1
      Task.once( i, guard:3, ident: ident ) do |j|
        expect( j ).to be == 1
      end
    end
 
    tasks1.each(&:join)
    tasks2.each(&:join)
  end

end
