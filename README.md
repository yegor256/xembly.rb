[![Managed by Zerocracy](http://www.zerocracy.com/badge.svg)](http://www.zerocracy.com)
[![DevOps By Rultor.com](http://www.rultor.com/b/yegor256/xembly-gem)](http://www.rultor.com/p/yegor256/xembly-gem)
[![We recommend RubyMine](https://www.elegantobjects.org/rubymine.svg)](https://www.jetbrains.com/ruby/)

[![Build Status](https://travis-ci.org/yegor256/xembly-gem.svg)](https://travis-ci.org/yegor256/xembly-gem)
[![Build status](https://ci.appveyor.com/api/projects/status/8e5dsjjemymfg510?svg=true)](https://ci.appveyor.com/project/yegor256/xembly-gem)
[![Gem Version](https://badge.fury.io/rb/xembly.svg)](http://badge.fury.io/rb/xembly)
[![Dependency Status](https://gemnasium.com/yegor256/xembly-gem.svg)](https://gemnasium.com/yegor256/xembly-gem)
[![Code Climate](http://img.shields.io/codeclimate/github/yegor256/xembly-gem.svg)](https://codeclimate.com/github/yegor256/xembly-gem)
[![Coverage Status](https://img.shields.io/coveralls/yegor256/xembly-gem.svg)](https://coveralls.io/r/yegor256/xembly-gem)

## Assembly for XML

Read this [blog post](http://www.yegor256.com/2014/04/09/xembly-intro.html)
and check this project: [yegor256/xembly](https://github.com/yegor256/xembly)

## How to Install?

You will need Ruby 2.0+:

```bash
$ gem install xembly
```

## How to Run?

Run it locally and read its output:

```bash
$ xembly --help
```

Say, you want to modify an existing XML document, which is
in file `doc.xml`:

```xml
<books>
  <book isbn="0735619654">Object Thinking</book>
  <book isbn="1519166915">Elegant Objects</book>
</books>
```

Now, say, you want to add one more book there:

```
$ xembly --xml doc.xml 'XPATH "/books"; ADD "book"; ATTR "isbn", "0201379430"; SET "Object Design";'
<books>
  <book isbn="0735619654">Object Thinking</book>
  <book isbn="1519166915">Elegant Objects</book>
  <book isbn="0201379430">Object Design</book>
</books>
```

Simple as that!

Full specification of Xembly language is
[here](https://github.com/yegor256/xembly).
