# frozen_string_literal: true

#
# SPDX-FileCopyrightText: Copyright (c) 2016-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'xembly/remove'
require 'test__helper'

# Xembly::Remove tests.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2016-2025 Yegor Bugayenko
# License:: MIT
class TestRemove < XeTest
  def test_adds_nodes
    dom = Nokogiri::XML('<books><book id="1"/><book id="2"/></books>')
    Xembly::Remove.new.exec(dom, [dom.xpath('/books/book[@id=1]').first])
    matches(
      dom.to_xml,
      [
        '/books',
        '/books[count(book)=1]'
      ]
    )
  end
end
