# frozen_string_literal: true

#
# Copyright (c) 2016-2025 Yegor Bugayenko
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

require 'nokogiri'
require 'tmpdir'
require 'slop'
require 'English'
require_relative '../../lib/xembly'

Before do
  @cwd = Dir.pwd
  @dir = Dir.mktmpdir('test')
  FileUtils.mkdir_p(@dir)
  Dir.chdir(@dir)
end

After do
  Dir.chdir(@cwd)
  FileUtils.rm_rf(@dir)
end

Given(/^I have a "([^"]*)" file with content:$/) do |file, text|
  FileUtils.mkdir_p(File.dirname(file)) unless File.exist?(file)
  File.write(file, text.gsub('\\xFF', 0xff.chr))
end

Then(/^XML matches "([^"]+)"$/) do |xpath|
  raise "XML doesn't match \"#{xpath}\":\n#{@xml}" if @xml.xpath(xpath).empty?
end

When(%r{^I run bin/xembly with "([^"]*)"$}) do |arg|
  home = File.join(File.dirname(__FILE__), '../..')
  @stdout = `ruby -I#{home}/lib #{home}/bin/xembly #{arg}`
  @exitstatus = $CHILD_STATUS.exitstatus
end

Then(/^Stdout contains "([^"]*)"$/) do |txt|
  raise "STDOUT doesn't contain '#{txt}':\n#{@stdout}" unless @stdout.include?(txt)
end

Then(/^Stdout is empty$/) do
  raise "STDOUT is not empty:\n#{@stdout}" unless @stdout == ''
end

Then(/^XML file "([^"]+)" matches "((?:[^"]|\\")+)"$/) do |file, xpath|
  raise "File #{file} doesn't exit" unless File.exist?(file)

  xml = Nokogiri::XML.parse(File.read(file))
  xml.remove_namespaces!
  raise "XML file #{file} doesn't match \"#{xpath}\":\n#{xml}" if xml.xpath(xpath.gsub('\\"', '"')).empty?
end

Then(/^Exit code is zero$/) do
  raise "Non-zero exit code #{@exitstatus}" unless @exitstatus.zero?
end

Then(/^Exit code is not zero$/) do
  raise 'Zero exit code' if @exitstatus.zero?
end

When(/^I run bash with$/) do |text|
  FileUtils.copy_entry(@cwd, File.join(@dir, 'xembly'))
  @stdout = `#{text}`
  @exitstatus = $CHILD_STATUS.exitstatus
end

Given(/^It is Unix$/) do
  pending if Gem.win_platform?
end

Given(/^It is Windows$/) do
  pending unless Gem.win_platform?
end
