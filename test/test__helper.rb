# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2016-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'minitest/autorun'
require 'nokogiri'
require 'simplecov'
require_relative '../lib/xembly'

# Xembly test, parent class.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2016-2026 Yegor Bugayenko
# License:: MIT
class XeTest < Minitest::Test
  def matches(xml, xpaths)
    xpaths.each do |xpath|
      raise(StandardError, "doesn't match '#{xpath}': #{xml}") \
        unless Nokogiri::XML(xml).xpath(xpath).size == 1
    end
  end
end
