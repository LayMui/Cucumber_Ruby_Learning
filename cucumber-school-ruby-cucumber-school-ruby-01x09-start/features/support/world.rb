module ShoutyWorld

  def people
    @people ||= {}
  end

  def messages_shouted_by
    @messages_shouted_by ||= {}
  end

  def sean_shout(message)
    people['Sean'].shout(message)
    messages_shouted_by['Sean'] ||= []
    messages_shouted_by['Sean'] << message
  end

end

World(ShoutyWorld)
