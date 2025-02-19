# frozen_string_literal: true

#
# SPDX-FileCopyrightText: Copyright (c) 2016-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'minitest/autorun'
require 'nokogiri'
require 'xembly/xembler'
require 'xembly/directives'
require_relative 'test__helper'

# Xembly::Xembler module tests.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2016-2025 Yegor Bugayenko
# License:: MIT
class TestXembler < XeTest
  def test_modifies_xml
    xembler = Xembly::Xembler.new(
      Xembly::Directives.new(
        'XPATH "/books"; ADD "book"; ADD "test"; UP;' \
        'ADD "title"; SET "hi;you";' \
        'XPATH "none"; XPATH "/none-again";' \
        'XPATH "/books"; ATTR "amp", "test";' \
        'ADD "temp"; ADD "t1"; UP; XPATH "t1"; REMOVE; ADD "t2";'
      )
    )
    matches(
      xembler.apply('<books/>').to_xml,
      [
        '/*',
        '/books[@amp]',
        '/books[count(book)=1]',
        '/books/book[test and title]',
        '/books/book/title[.="hi;you"]'
      ]
    )
  end
end
