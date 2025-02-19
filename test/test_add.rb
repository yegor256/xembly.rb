# frozen_string_literal: true

#
# SPDX-FileCopyrightText: Copyright (c) 2016-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'xembly/add'
require 'test__helper'

# Xembly::Add tests.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2016-2025 Yegor Bugayenko
# License:: MIT
class TestAdd < XeTest
  def test_adds_nodes
    dom = Nokogiri::XML('<books/>')
    Xembly::Add.new('book').exec(dom, [dom.xpath('/*').first])
    matches(
      dom.to_xml,
      [
        '/books',
        '/books[count(book)=1]'
      ]
    )
  end

  def test_adds_nodes_to_empty_dom
    dom = Nokogiri::XML('')
    Xembly::Add.new('dude').exec(dom, [dom])
    matches(
      dom.to_xml,
      [
        '/dude'
      ]
    )
  end
end
