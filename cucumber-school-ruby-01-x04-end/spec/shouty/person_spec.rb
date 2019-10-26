require 'shouty'

describe Person do
  let(:network) { double.as_null_object }

  it "subscribes to the network" do
    expect(network).to receive(:subscribe)
    sean = Person.new(network)
  end

  it "broadcasts shouts to the network" do
    message = "Free bagels!"
    sean = Person.new(network)
    expect(network).to receive(:broadcast).with message
    sean.shout message
  end

  it "remembers messages heard" do
    message = "Free bagels!"
    lucy = Person.new(network)
    lucy.hear(message)
    expect(lucy.messages_heard).to eq [message]
  end

end
