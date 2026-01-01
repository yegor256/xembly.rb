# frozen_string_literal: true

#
# SPDX-FileCopyrightText: Copyright (c) 2016-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require_relative 'add'
require_relative 'addif'
require_relative 'attr'
require_relative 'remove'
require_relative 'set'
require_relative 'strict'
require_relative 'up'
require_relative 'xpath'

module Xembly
  # Directives
  class Directives
    # Ctor.
    # +text+:: Directives in text
    def initialize(text)
      @array = text
               .strip
               .scan(/([A-Za-z]+)(?:\s+"([^"]+)")?(?:\s*,\s*"([^"]+)")*\s*;/)
               .map(&:compact)
               .map { |t| Directives.map(t) }
    end

    def each(&block)
      @array.each(&block)
    end

    def length
      @array.length
    end

    def self.map(cmd)
      args = cmd.drop(1)
      case cmd[0].upcase
      when 'ADD'
        Add.new(args[0])
      when 'ADDIF'
        AddIf.new(args[0])
      when 'ATTR'
        Attr.new(args[0], args[1])
      when 'CDATA'
        raise 'CDATA command is not supported yet, please contribute'
      when 'NS'
        raise 'NS command is not supported yet, please contribute'
      when 'PI'
        raise 'PI command is not supported yet, please contribute'
      when 'POP'
        raise 'POP command is not supported yet, please contribute'
      when 'PUSH'
        raise 'PUSH command is not supported yet, please contribute'
      when 'REMOVE'
        Remove.new
      when 'SET'
        Set.new(args[0])
      when 'STRICT'
        Strict.new(args[0])
      when 'UP'
        Up.new
      when 'XPATH'
        Xpath.new(args[0])
      when 'XSET'
        raise 'XSET command is not supported yet, please contribute'
      else
        raise "Unknown command \"#{cmd}\""
      end
    end
  end
end
