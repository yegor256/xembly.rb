# encoding: utf-8
#
# Copyright (c) 2016 Yegor Bugayenko
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
require 'xembly/up'
require 'xembly/xpath'
require 'xembly/set'

module Xembly
  # Directives
  class Directives
    # Ctor.
    # +text+:: Directives in text
    def initialize(text)
      @array = text
        .strip
        .split(/\s*;\s*/)
        .reject(&:empty?)
        .map { |t| Directives.map(t) }
    end

    def each(&block)
      @array.each(&block)
    end

    def length
      @array.length
    end

    def self.map(text)
      cmd, tail = text.strip.split(/\s+/, 2)
      args = (tail.nil? ? '' : tail).strip
        .scan(/"([^"]+)"/)
        .flatten
        .map { |a| a.tr('"', '') }
      case cmd.upcase
      when 'ADD'
        Add.new(args[0])
      when 'ADDIF'
        AddIf.new(args[0])
      when 'ATTR'
        Attr.new(args[0], args[1])
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
      else
        fail "Unknown command \"#{cmd}\""
      end
    end
  end
end
