# encoding: utf-8
#
# Copyright (c) 2016-2018 Yegor Bugayenko
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

require 'xembly/version'
require 'xembly/xembler'
require 'xembly/directives'
require 'nokogiri'
require 'logger'
require 'time'

# Xembly main module.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2016-2018 Yegor Bugayenko
# License:: MIT
module Xembly
  # Get logger.
  def self.log
    unless @logger
      @logger = Logger.new(STDOUT)
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
        xml = STDIN.read
        Xembly.log.info 'reading STDIN'
      end
      if @opts.dirs?
        Xembly.log.info "reading directives from #{@opts[:dirs]}"
        dirs = File.read(@opts[:dirs])
      else
        Xembly.log.info "#{@opts.arguments.length} directives in command line"
        dirs = @opts.arguments.join('')
      end
      Xembler.new(Directives.new(dirs)).apply(xml).to_xml
    end
  end
end
