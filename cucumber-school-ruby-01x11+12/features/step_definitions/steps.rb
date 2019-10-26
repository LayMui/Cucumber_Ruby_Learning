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
      people[name] = Person.new(@network, location)
    end
end

When(/^Sean shouts (\d+) messages containing the word "(.*?)"$/) do |num, word|
  num.to_i.times do
    sean_shout "here is a message containing the word #{word}"
  end
end

When(/^Sean shouts (\d+) over\-long messages$/) do |num|
  num.to_i.times do
    sean_shout "x" * 181
  end
end

When(/^Sean shouts an over\-long message containing the word "(.*?)"$/) do |word|
  sean_shout "x" * 181 + word
end

When(/^Sean shouts an over\-long message$/) do
  sean_shout "x" * 181
end

When(/^Sean shouts a long message$/) do
  sean_shout "x" * 180
end

When(/^Sean shouts a message containing the word "(.*?)"$/) do |word|
  sean_shout "here is a message containing the word #{word}"
end

When(/^Sean shouts a message$/) do
  sean_shout "here is a message"
end

When(/^Sean shouts "(.*?)"$/) do |message|
  sean_shout message
end

When(/^Sean shouts:$/) do |message|
  sean_shout message
end

Then(/^Lucy hears Sean's message$/) do
  expect(messages_heard_by('Lucy')).to include messages_shouted_by['Sean'].last
end

Then(/^(Larry|Lucy) does not hear Sean's message$/) do |listener_name|
  expect(messages_heard_by(listener_name)).to_not include messages_shouted_by['Sean'].last
end

Then(/^nobody hears Sean's message$/) do
  people.keys.each do |name|
    expect(messages_heard_by(name)).to_not include messages_shouted_by['Sean'].last
  end
end

Then(/^Lucy hears the following messages:$/) do |expected_messages|
  actual_messages = messages_heard_by('Lucy').map { |message| [ message ] }
  expected_messages.diff!(actual_messages)
end

Given(/^Sean has bought (\d+) credits$/) do |credits|
  people['Sean'].credits = credits.to_i
end

Then(/^Larry hears both Sean's messages$/) do
  messages_shouted_by['Sean'].each do |message|
    expect(messages_heard_by('Larry')).to include message
  end
end

Then(/^Lucy hears all Sean's messages$/) do
  messages_shouted_by['Sean'].each do |message|
    expect(messages_heard_by('Lucy')).to include message
  end
end

Then(/^Sean should have (\d+) credits$/) do |expected_credits|
  expect(people['Sean'].credits).to eq expected_credits.to_i
end
