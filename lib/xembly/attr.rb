# frozen_string_literal: true

#
# SPDX-FileCopyrightText: Copyright (c) 2016-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require_relative '../xembly/base'

module Xembly
  # ATTR directive
  class Attr
    # Ctor.
    # +name+:: Attribute name
    # +val+:: Attribute value
    def initialize(name, value)
      @name = name
      @value = value
    end

    def exec(_, cursor)
      cursor.each do |node|
        node[@name] = @value
        Xembly.log.info "attribute \"#{@name}\" set for node \"#{node.name}\""
      end
      cursor
    end
  end
end
