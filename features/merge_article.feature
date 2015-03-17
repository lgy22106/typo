Feature: Merge Article
  As an admin
  I want to merge articles into a new article
  So that there aren't too many duplicate ones

  Background:
    Given the blog is set up
    And I created article "test1" with body "1234"
    And I created article "test2" with body "12345"

  Scenario: Non-admin cannot merge articles
    Given I am logged in as user
    And I am on the edit article page for "1"
    Then I should not see "Merge Articles"

  Scenario: When articles are merged, the merged article should contain the text of both previous articles
    And I am logged into the admin panel
    Given I am on the edit article page for "1"
    When I fill in "merge_with" with "2"
    And I press "Merge"
    Then I go to the home page
    Then I follow "test1"
    Then I should see "123412345"