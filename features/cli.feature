Feature: Command Line Processing
  As an owner of XML documetn I want to be able to
  call Xembly as a command line tool and modify it

  Scenario: Help can be printed
    When I run bin/xembly with "--help"
    Then Exit code is zero
    And Stdout contains "-v, --verbose"

  Scenario: Version can be printed
    When I run bin/xembly with "--version"
    Then Exit code is zero

  Scenario: Simple XML manipulations
    Given I have a "text.xml" file with content:
    """
    <books>
      <book id="1"/>
      <book id="2"/>
    </books>
    """
    And I have a "dirs.txt" file with content:
    """
    XPATH "/books";
    ADD "book";
    """
    When I run bin/xembly with "-v -d dirs.txt -f out.xml -x text.xml"
    Then Exit code is zero
    And Stdout contains "reading text.xml"
    And XML file "out.xml" matches "/books[count(book) = 3]"

  Scenario: Rejects unknown options
    When I run bin/xembly with "--some-unknown-option"
    Then Exit code is not zero
