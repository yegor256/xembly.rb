# frozen_string_literal: true

#
# SPDX-FileCopyrightText: Copyright (c) 2016-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

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
