# frozen_string_literal: true

#
# SPDX-FileCopyrightText: Copyright (c) 2016-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'nokogiri'
require_relative '../xembly/base'

module Xembly
  # XPATH directive
  class Xpath
    # Ctor.
    # +path+:: Path
    def initialize(path)
      @path = path
    end

    def exec(dom, cursor)
      if @path.start_with?('/')
        after = dom.xpath(@path)
      else
        after = []
        cursor.each do |node|
          node.xpath(@path).each { |n| after.push(n) }
        end
      end
      after
    end
  end
end
