require 'shouty'

describe Network do

  let(:network) { Network.new(range) }
  let(:range) { 100 }
  let(:message) { "Free bagels!" }

  describe "#broadcast" do

    describe "broadcasting to listeners" do

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

      it "does not error when broadcasting with nobody subscribed" do
        sean = double(location: 0)
        expect { network.broadcast message, sean }.not_to raise_error
      end

    end

  end

end
