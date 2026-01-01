# frozen_string_literal: true

#
# SPDX-FileCopyrightText: Copyright (c) 2016-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'nokogiri'
require 'logger'
require 'time'

# Xembly main module.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2016-2026 Yegor Bugayenko
# License:: MIT
module Xembly
  # Get logger.
  def self.log
    unless @logger
      @logger = Logger.new($stdout)
      @logger.formatter = proc { |severity, _, _, msg|
        "#{severity}: #{msg.dump}\n"
      }
      @logger.level = Logger::ERROR
    end
    @logger
  end

  class << self
    attr_writer :logger
  end

  # Code base abstraction
  class Base
    # Ctor.
    # +opts+:: Options
    def initialize(opts)
      @opts = opts
      Xembly.log.level = Logger::INFO if @opts.verbose?
      Xembly.log.info "my version is #{Xembly::VERSION}"
      Xembly.log.info "Ruby version is #{RUBY_VERSION} at #{RUBY_PLATFORM}"
    end

    # Generate XML.
    def xml
      if @opts.xml?
        xml = File.read(@opts[:xml])
        Xembly.log.info "reading #{@opts[:xml]}"
      else
        xml = $stdin.read
        Xembly.log.info 'reading STDIN'
      end
      if @opts.dirs?
        Xembly.log.info "reading directives from #{@opts[:dirs]}"
        dirs = File.read(@opts[:dirs])
      else
        Xembly.log.info "#{@opts.arguments.length} directives in command line"
        dirs = @opts.arguments.join
      end
      Xembler.new(Directives.new(dirs)).apply(xml).to_xml
    end
  end
end
