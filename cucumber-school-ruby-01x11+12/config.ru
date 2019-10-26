$LOAD_PATH << File.dirname(__FILE__) + '/lib'
require 'shouty'
network = Network.new(100)
people = {
  'Sean' => Person.new(network, 0),
  'Lucy' => Person.new(network, 100),
  'Larry' => Person.new(network, 150)
}
run WebApp.new(nil, people)
