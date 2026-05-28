# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2016-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'English'
require 'nokogiri'
require 'slop'
require 'tmpdir'
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
  raise(StandardError, "XML doesn't match \"#{xpath}\":\n#{@xml}") if @xml.xpath(xpath).empty?
end

When(%r{^I run bin/xembly with "([^"]*)"$}) do |arg|
  home = File.join(File.dirname(__FILE__), '../..')
  @stdout = `ruby -I#{home}/lib #{home}/bin/xembly #{arg}`
  @exitstatus = $CHILD_STATUS.exitstatus
end

Then(/^Stdout contains "([^"]*)"$/) do |txt|
  raise(StandardError, "STDOUT doesn't contain '#{txt}':\n#{@stdout}") unless @stdout.include?(txt)
end

Then(/^Stdout is empty$/) do
  raise(StandardError, "STDOUT is not empty:\n#{@stdout}") unless @stdout == ''
end

Then(/^XML file "([^"]+)" matches "((?:[^"]|\\")+)"$/) do |file, xpath|
  raise(StandardError, "File #{file} doesn't exist") unless File.exist?(file)
  xml = Nokogiri::XML.parse(File.read(file))
  xml.remove_namespaces!
  raise(StandardError, "XML file #{file} doesn't match \"#{xpath}\":\n#{xml}") \
    if xml.xpath(xpath.gsub('\\"', '"')).empty?
end

Then(/^Exit code is zero$/) do
  raise(StandardError, "Non-zero exit code #{@exitstatus}") unless @exitstatus.zero?
end

Then(/^Exit code is not zero$/) do
  raise(StandardError, 'Zero exit code') if @exitstatus.zero?
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
