# frozen_string_literal: true

#
# SPDX-FileCopyrightText: Copyright (c) 2016-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'nokogiri'
require_relative '../xembly/base'

module Xembly
  # ADD directive
  class Add
    # Ctor.
    # +name+:: Node name to add
    def initialize(name)
      @name = name
    end

    def exec(dom, cursor)
      after = []
      cursor.each do |node|
        child = Nokogiri::XML::Node.new(@name, dom)
        node.add_child(child)
        after.push(child)
        Xembly.log.info "node \"#{@name}\" added to \"#{node.name}\""
      end
      after
    end
  end
end
