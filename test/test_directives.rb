# frozen_string_literal: true

#
# SPDX-FileCopyrightText: Copyright (c) 2016-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'minitest/autorun'
require 'nokogiri'
require 'xembly/directives'

# Xembly::Directives module tests.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2016-2025 Yegor Bugayenko
# License:: MIT
class TestDirectives < Minitest::Test
  def test_parses_directives
    dirs = Xembly::Directives.new(
      "  ADD \"book;&quot;me\";UP;ATTR \"a1\", \"works, for\nme!\";  "
    )
    assert dirs.length == 3, 'three directives must be there'
  end
end
