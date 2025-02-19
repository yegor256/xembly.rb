# frozen_string_literal: true

#
# SPDX-FileCopyrightText: Copyright (c) 2016-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require_relative '../xembly/base'

module Xembly
  # REMOVE directive
  class Remove
    def exec(_, cursor)
      after = []
      cursor.each do |node|
        Xembly.log.info "node \"#{node.name}\" removed"
        parent = node.parent
        node.remove
        after.push(parent)
      end
      after
    end
  end
end
