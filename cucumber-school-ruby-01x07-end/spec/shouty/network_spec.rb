require 'shouty'

describe Network do

  let(:network) { Network.new(range) }
  let(:range) { 100 }
  let(:message) { "Free bagels!" }

  it "broadcasts a message to a listener within range" do
    sean = double(location: 0)
    lucy = double(location: 100)
    network.subscribe(lucy)
    expect(lucy).to receive(:hear).with(message)
    network.broadcast message, sean
  end

  it "does not broadcast a message to a listener out of range" do
    sean = double(location: 0)
    laura = double(location: 101)
    network.subscribe(laura)
    expect(laura).not_to receive(:hear).with(message)
    network.broadcast message, sean
  end

  it "does not broadcast a message to a listener our of range (negative distance)" do
    sally = double(location: 101)
    lionel = double(location: 0)
    network.subscribe(lionel)
    expect(lionel).not_to receive(:hear).with(message)
    network.broadcast message, sally
  end

  it "does not broadcast messages over 180 characters, even when the listener is within range" do
    sean = double(location: 0, credits: -1).as_null_object # hack to keep specs passing
    long_message = "x" * 181
    lucy = double(location: 100)
    network.subscribe(lucy)
    expect(lucy).not_to receive(:hear)
    network.broadcast long_message, sean
  end

end
