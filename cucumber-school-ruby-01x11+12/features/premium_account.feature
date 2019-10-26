Feature: Premium account

  Rules:
    - mention the word "buy" and you lose 5 credits per shout
    - over-long messages cost 2 credits
    - you can't send a premium shout unless you have enough credits
    - charge 7 credits for over-long messages that contain "buy"

  Background:
    Given the range is 100
    And the following people:
      | name     | Sean | Lucy |
      | location | 0    | 100  |

  Scenario: Shout several over-long messages
    Given Sean has bought 30 credits
    When Sean shouts 2 over-long messages
    Then Lucy hears all Sean's messages
    And Sean should have 26 credits

  Scenario: Shout the word "buy" several times
    Given Sean has bought 30 credits
    When Sean shouts 3 messages containing the word "buy"
    Then Lucy hears all Sean's messages
    And Sean should have 15 credits

  Scenario: Mention the word "buy" several times in the same shout
    Given Sean has bought 100 credits
    When Sean shouts "buy, buy buy!"
    Then Sean should have 95 credits

  Scenario: Run out of credit
    Given Sean has bought 4 credits
    When Sean shouts a message containing the word "buy"
    Then Lucy does not hear Sean's message
    And Sean should have 4 credits

  Scenario: Over-long message containing "buy"
    Given Sean has bought 100 credits
    When Sean shouts an over-long message containing the word "buy"
    Then Lucy hears all Sean's messages
    And Sean should have 93 credits
