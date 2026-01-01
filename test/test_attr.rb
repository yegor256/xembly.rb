# frozen_string_literal: true

#
# SPDX-FileCopyrightText: Copyright (c) 2016-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'xembly/attr'
require 'test__helper'

# Xembly::Attr tests.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2016-2026 Yegor Bugayenko
# License:: MIT
class TestAttr < XeTest
  def test_sets_attributes
    dom = Nokogiri::XML('<book/>')
    Xembly::Attr.new('id', '4').exec(dom, [dom.xpath('/*').first])
    matches(
      dom.to_xml,
      [
        '/book[@id=4]'
      ]
    )
  end
end
