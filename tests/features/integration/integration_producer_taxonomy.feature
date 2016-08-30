@api @integration
Feature: Integration producer taxonomy
  In order to share my content and taxonomy with other websites
  As a site administrator
  I can push content published on my website to the Integration Layer

  Background:
    Given these modules are enabled
      | modules                |
      | nexteuropa_integration |
      | integration_producer   |
    And I am logged in as a user with the 'administrator' role

  Scenario: producers will produce a valid document for content containing title, body and taxonomy term reference
    Given "tags" terms:
      | name  |
      | Tag 1 |
      | Tag 2 |
    And "article" content:
      | title           | body           | field_tags   |
      | Article title 1 | Article body 1 | Tag 1, Tag 2 |
    And "article" content:
      | title           | body           |
      | Article title 2 | Article body 2 |
    When the following Integration Layer resource schema is created:
    """
      name: article
      fields:
        title: Title
        body: Body
        tags: Tags
    """
    And the following Integration Layer node producer is created:
    """
      name: article
      bundle: article
      resource: article
      mapping:
        title: title
        body: body
        field_tags: tags
    """
    Then the "article" producer builds the following document for the "article" with title "Article title 1":
    """
      version: v1
      default_language: und
      type: article
      languages:
        - und
      fields:
        title:
          und:
            - Article title 1
        body:
          und:
            - Article body 1
        tags:
          und:
            - Tag 1
            - Tag 2
    """
    And the "article" producer builds the following document for the "article" with title "Article title 2":
    """
      version: v1
      default_language: und
      type: article
      languages:
        - und
      fields:
        title:
          und:
            - Article title 2
        body:
          und:
            - Article body 2
    """
