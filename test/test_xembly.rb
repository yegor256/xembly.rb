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

require 'minitest/autorun'
require 'nokogiri'
require 'xembly'
require 'tmpdir'
require 'slop'
require 'test__helper'

# Xembly main module test.
# Author:: Yegor Bugayenko (yegor@teamed.io)
# Copyright:: Copyright (c) 2016 Yegor Bugayenko
# License:: MIT
class TestXembly < XeTest
  def test_basic
    opts = opts(['-x', '/dev/null', 'ADD "books"', 'ADD "book"'])
    matches(
      Xembly::Base.new(opts).xml,
      [
        '/books',
        '/books[count(book)=1]',
      ]
    )
  end

  def test_reading_from_file
    Dir.mktmpdir 'test' do |dir|
      xml = File.join(dir, 'input.xml')
      File.write(xml, '<books/>')
      dirs = File.join(dir, 'dirs.txt')
      File.write(dirs, 'XPATH "/books"; ADD "book"; ATTR "id", "123";')
      opts = opts(['--xml', xml, '--dirs', dirs])
      matches(
        Xembly::Base.new(opts).xml,
        [
          '/books',
          '/books[count(book)=1]',
          '/books/book[@id=123]',
        ]
      )
    end
  end

  private

  def opts(args)
    Slop.parse args do |o|
      o.on '-v', '--verbose'
      o.string '-x', '--xml', argument: :required
      o.string '-d', '--dirs', argument: :required
    end
  end
end
