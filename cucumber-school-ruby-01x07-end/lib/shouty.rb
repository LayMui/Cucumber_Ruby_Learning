class Person
  attr_reader :messages_heard, :location
  attr_accessor :credits

  def initialize(network, location)
    network.subscribe(self)
    @network, @location = network, location
    @messages_heard = []
    @credits = 0
  end

  def shout(message)
    @network.broadcast(message, self)
  end

  def hear(message)
    messages_heard << message
  end

end

class Network
  def initialize(range)
    @range = range
  end

  def subscribe(listener)
    @listeners ||= []
    @listeners << listener
  end

  def broadcast(message, shouter)
    shouter_location = shouter.location
    short_enough = message.length <= 180
    deduct_credits(short_enough, message, shouter)
    @listeners.each do |listener|
      within_range = (listener.location - shouter_location).abs <= @range
      if (within_range && (short_enough || (shouter.credits >= 0)))
        listener.hear message
      end
    end
  end

  private

  def deduct_credits(short_enough, message, shouter)
    shouter.credits -= 2 if !short_enough
    message.scan(/buy/i).each do
      shouter.credits -= 5
    end
  end

end
