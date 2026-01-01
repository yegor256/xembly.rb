# frozen_string_literal: true

#
# SPDX-FileCopyrightText: Copyright (c) 2016-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require_relative '../xembly/base'

module Xembly
  # Xembler
  class Xembler
    # Ctor.
    # +dirs+:: Directives
    def initialize(dirs)
      @dirs = dirs
    end

    # Apply them to the XML.
    def apply(xml)
      dom = Nokogiri::XML(xml)
      cursor = [dom]
      @dirs.each do |dir|
        cursor = dir.exec(dom, cursor)
        Xembly.log.info "Applied: #{dir}"
      end
      Xembly.log.info "#{@dirs.length} directive(s) applied"
      dom
    end
  end
end
