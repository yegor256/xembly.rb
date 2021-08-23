# frozen_string_literal: true

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

require 'xembly/addif'
require 'test__helper'

# Xembly::AddIf tests.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2016-2021 Yegor Bugayenko
# License:: MIT
class TestAddIf < XeTest
  def test_skips_nodes
    dom = Nokogiri::XML('<books><book/></books>')
    Xembly::AddIf.new('book').exec(dom, [dom.xpath('/*').first])
    matches(
      dom.to_xml,
      [
        '/books',
        '/books[count(book)=1]'
      ]
    )
  end

  def test_adds_nodes
    dom = Nokogiri::XML('<books><book/></books>')
    Xembly::AddIf.new('book-2').exec(dom, [dom.xpath('/*').first])
    matches(
      dom.to_xml,
      [
        '/books',
        '/books[count(book)=1]',
        '/books[count(book-2)=1]'
      ]
    )
  end
end
