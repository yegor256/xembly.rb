# frozen_string_literal: true

#
# SPDX-FileCopyrightText: Copyright (c) 2016-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'xembly/set'
require 'test__helper'

# Xembly::Set tests.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2016-2026 Yegor Bugayenko
# License:: MIT
class TestSet < XeTest
  def test_sets_values
    dom = Nokogiri::XML('<books><book/></books>')
    Xembly::Set.new('hello').exec(dom, [dom.xpath('/books/book').first])
    matches(
      dom.to_xml,
      [
        '/books',
        '/books[count(book)=1]',
        '/books/book[.="hello"]'
      ]
    )
  end
end
