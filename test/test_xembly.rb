# frozen_string_literal: true

#
# SPDX-FileCopyrightText: Copyright (c) 2016-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'minitest/autorun'
require 'nokogiri'
require 'tmpdir'
require 'slop'
require_relative '../lib/xembly'
require_relative 'test__helper'

# Xembly main module test.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2016-2026 Yegor Bugayenko
# License:: MIT
class TestXembly < XeTest
  def test_basic
    opts = opts(['-x', '/dev/null', 'ADD "books";', 'ADD "book";'])
    matches(
      Xembly::Base.new(opts).xml,
      [
        '/books',
        '/books[count(book)=1]'
      ]
    )
  end

  def test_reading_from_file
    Dir.mktmpdir 'test' do |dir|
      xml = File.join(dir, 'input.xml')
      File.write(xml, '<books/>')
      dirs = File.join(dir, 'dirs.txt')
      File.write(
        dirs,
        'XPATH "/books"; ADD "book"; ATTR "id", "123"; SET "Elegant Objects";'
      )
      opts = opts(['--xml', xml, '--dirs', dirs])
      matches(
        Xembly::Base.new(opts).xml,
        [
          '/books',
          '/books[count(book)=1]',
          '/books/book[@id=123]',
          '/books/book[@id=123 and .="Elegant Objects"]'
        ]
      )
    end
  end

  private

  def opts(args)
    Slop.parse(args, help: true) do |o|
      o.on '-v', '--verbose'
      o.string '-x', '--xml', argument: :required
      o.string '-d', '--dirs', argument: :required
    end
  end
end
