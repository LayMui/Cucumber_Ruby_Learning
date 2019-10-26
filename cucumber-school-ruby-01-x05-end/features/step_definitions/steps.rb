require 'shouty'

Before do
  @people = {}
end

Given(/^the range is (\d+)$/) do |range|
  @network = Network.new(range.to_i)
end

Given(/^the following people:$/) do |table|
  table
    .transpose
    .map_column('location') { |raw_location| raw_location.to_i }
    .hashes.each do |row|
      name = row['name']
      location = row['location']
      @people[name] = Person.new(@network, location)
    end
end

When(/^Sean shouts "(.*?)"$/) do |message|
  @people['Sean'].shout(message)
  @message_from_sean = message
end

When(/^Sean shouts:$/) do |message|
  @people['Sean'].shout(message)
  @message_from_sean = message
end

Then(/^Lucy hears Sean's message$/) do
  expect(@people['Lucy'].messages_heard).to include @message_from_sean
end

Then(/^Larry does not hear Sean's message$/) do
  expect(@people['Larry'].messages_heard).to_not include @message_from_sean
end

Then(/^nobody hears Sean's message$/) do
  @people.values.each do |person|
    expect(person.messages_heard).to_not include @message_from_sean
  end
end

Then(/^Lucy hears the following messages:$/) do |expected_messages|
  lucy = @people['Lucy']
  actual_messages = lucy.messages_heard.map { |message| [ message ] }
  expected_messages.diff!(actual_messages)
end
