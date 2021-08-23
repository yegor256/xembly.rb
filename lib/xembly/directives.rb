# encoding: utf-8

#
# Copyright (c) 2016-2021 Yegor Bugayenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require 'xembly/add'
require 'xembly/addif'
require 'xembly/attr'
require 'xembly/remove'
require 'xembly/set'
require 'xembly/strict'
require 'xembly/up'
require 'xembly/xpath'

module Xembly
  # Directives
  class Directives
    # Ctor.
    # +text+:: Directives in text
    def initialize(text)
      @array = text
               .strip
               .scan(/([A-Za-z]+)(?:\s+"([^"]+)")?(?:\s*,\s*"([^"]+)")*\s*;/)
               .map { |t| t.reject(&:nil?) }
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
        fail 'CDATA command is not supported yet, please contribute'
      when 'NS'
        fail 'NS command is not supported yet, please contribute'
      when 'PI'
        fail 'PI command is not supported yet, please contribute'
      when 'POP'
        fail 'POP command is not supported yet, please contribute'
      when 'PUSH'
        fail 'PUSH command is not supported yet, please contribute'
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
        fail 'XSET command is not supported yet, please contribute'
      else
        fail "Unknown command \"#{cmd}\""
      end
    end
  end
end
