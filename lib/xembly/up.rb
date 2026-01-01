# frozen_string_literal: true

#
# SPDX-FileCopyrightText: Copyright (c) 2016-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'nokogiri'
require_relative '../xembly/base'

module Xembly
  # UP directive
  class Up
    def exec(_, cursor)
      after = []
      cursor.each do |node|
        after.push(node.parent)
      end
      after
    end
  end
end
