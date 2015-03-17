Feature: Merge Article
  As an admin
  I want to merge articles into a new article
  So that there aren't too many duplicate ones

  Background:
    Given the blog is set up


  Scenario: Non-admin cannot merge articles
    Given I am logged in as user
    And I am on the edit article page for "1"
    Then I should not see "Merge Articles"

  Scenario: When articles are merged, the merged article should contain the text of both previous articles
    Given I am logged into the admin panel
    And I created article "test2" with body "hello"
    And I created article "test3" with body "abc"
    Given I am on the edit article page for "3"
    When I fill in "merge_with" with "4"
    And I press "Merge"
    Then I go to the home page
    Then I follow "test2"
    Then I should see "abc"
    And I should see "hello"
  Scenario: When articles are merged, the merged article should have one author (either one of the authors of the original article).
    Given I am logged in as user
    And I created article "test2" with body "hello"
    Then I go to the admin all article page
    Then I follow "Log out"
    Given I am logged into the admin panel
    And I created article "test3" with body "abc"
    Given I am on the edit article page for "3"
    When I fill in "merge_with" with "4"
    And I press "Merge"
    Then I go to the admin all article page
    Then I should see "user"
  Scenario: Comments on each of the two original articles need to all carry over and point to the new, merged article.
    Given I am logged into the admin panel
    And I created article "test2" with body "hello"
    And I created article "test3" with body "abc"
    Given I am on the edit article page for "3"
    When I fill in "merge_with" with "4"
    And I press "Merge"
    Then I go to the home page
    Then I follow "test2"
    Then I should see "comments for test2"
    And I should see "comments for test3"
  Scenario: The title of the new article should be the title from either one of the merged articles.
    Given I am logged into the admin panel
    And I created article "test2" with body "hello"
    And I created article "test3" with body "abc"
    Given I am on the edit article page for "3"
    When I fill in "merge_with" with "4"
    And I press "Merge"
    Then I go to the home page
    Then I should see "test2"
