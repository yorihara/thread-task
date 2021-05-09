
RSpec.describe Thread::Task do
  it "::Thread::Task.new" do
    expect( ::Thread::Task.new do end ).not_to be nil
  end

  it "::Task.new" do
    expect( ::Task.new do end ).not_to be nil
  end
end
