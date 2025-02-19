# frozen_string_literal: true

#
# SPDX-FileCopyrightText: Copyright (c) 2016-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'nokogiri'
require_relative '../xembly/base'

module Xembly
  # ADDIF directive
  class AddIf
    # Ctor.
    # +name+:: Node name to add
    def initialize(name)
      @name = name
    end

    def exec(dom, cursor)
      after = []
      cursor.each do |node|
        if node.element_children.none? { |e| e.name == @name }
          child = Nokogiri::XML::Node.new(@name, dom)
          node.add_child(child)
          after.push(child)
          Xembly.log.info "node \"#{@name}\" added to \"#{node.name}\""
        else
          after.push(node)
        end
      end
      after
    end
  end
end
