# frozen_string_literal: true

#
# SPDX-FileCopyrightText: Copyright (c) 2016-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'nokogiri'
require_relative '../xembly/base'

module Xembly
  # STRICT directive
  class Strict
    # Ctor.
    # +count+:: How many nodes to expect
    def initialize(count)
      @count = count.to_i
    end

    def exec(_, cursor)
      raise "there are #{cursor.length} nodes, while #{@count} expected" unless \
        cursor.length == @count

      cursor
    end
  end
end
