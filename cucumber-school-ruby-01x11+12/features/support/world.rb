module DomainWorld
  def people
    @people ||= {}
  end

  def messages_shouted_by
    @messages_shouted_by ||= {}
  end

  def messages_heard_by(name)
    people[name].messages_heard
  end

  def sean_shout(message)
    people['Sean'].shout(message)
    messages_shouted_by['Sean'] ||= []
    messages_shouted_by['Sean'] << message
  end
end

module WebWorld

  def people
    @people ||= {}
  end

  def messages_shouted_by
    @messages_shouted_by ||= {}
  end

  def messages_heard_by(name)
    log_in_as name
    all(".message").map { |node| node.text }
  end

  def sean_shout(message)
    log_in_as 'Sean'
    shout message
    messages_shouted_by['Sean'] ||= []
    messages_shouted_by['Sean'] << message
  end

  private

  def log_in_as(name)
    visit "/?name=#{name}"
  end

  def shout(message)
    fill_in('Message', with: message)
    click_button 'Shout'
  end
end

if ENV['shouty_test_depth'] == "web"
  require 'capybara/cucumber'
  Capybara.default_driver = :selenium
  Before do
    Capybara.app = WebApp.new(nil, people)
  end
  World(WebWorld)
else
  World(DomainWorld)
end
