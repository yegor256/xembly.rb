# frozen_string_literal: true

#
# SPDX-FileCopyrightText: Copyright (c) 2016-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'xembly/addif'
require 'test__helper'

# Xembly::AddIf tests.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2016-2025 Yegor Bugayenko
# License:: MIT
class TestAddIf < XeTest
  def test_skips_nodes
    dom = Nokogiri::XML('<books><book/></books>')
    Xembly::AddIf.new('book').exec(dom, [dom.xpath('/*').first])
    matches(
      dom.to_xml,
      [
        '/books',
        '/books[count(book)=1]'
      ]
    )
  end

  def test_adds_nodes
    dom = Nokogiri::XML('<books><book/></books>')
    Xembly::AddIf.new('book-2').exec(dom, [dom.xpath('/*').first])
    matches(
      dom.to_xml,
      [
        '/books',
        '/books[count(book)=1]',
        '/books[count(book-2)=1]'
      ]
    )
  end
end
