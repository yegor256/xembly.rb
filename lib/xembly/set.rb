# frozen_string_literal: true

#
# SPDX-FileCopyrightText: Copyright (c) 2016-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'nokogiri'
require_relative '../xembly/base'

module Xembly
  # SET directive
  class Set
    # Ctor.
    # +value+:: Text value to set
    def initialize(value)
      @value = value
    end

    def exec(_, cursor)
      cursor.each do |node|
        node.content = Nokogiri::HTML.parse(@value).text
        Xembly.log.info "node \"#{node.name}\" text content set"
      end
      cursor
    end
  end
end
