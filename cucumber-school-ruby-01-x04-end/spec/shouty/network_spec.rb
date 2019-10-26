require 'shouty'

describe Network do
  it "broadcasts a message to all listeners" do
    network = Network.new
    message = "Free bagels!"
    lucy = double.as_null_object
    network.subscribe(lucy)
    expect(lucy).to receive(:hear).with(message)
    network.broadcast message
  end
end
