<img src="https://www.xembly.org/logo.png" width="64px" height="64px" />

[![DevOps By Rultor.com](https://www.rultor.com/b/yegor256/xembly.rb)](https://www.rultor.com/p/yegor256/xembly.rb)
[![We recommend RubyMine](https://www.elegantobjects.org/rubymine.svg)](https://www.jetbrains.com/ruby/)

[![Gem Version](https://badge.fury.io/rb/xembly.svg)](https://badge.fury.io/rb/xembly)
[![Maintainability](https://api.codeclimate.com/v1/badges/f26349e81b04628d8bf7/maintainability)](https://codeclimate.com/github/yegor256/xembly.rb/maintainability)
[![Test Coverage](https://img.shields.io/codecov/c/github/yegor256/xembly.rb.svg)](https://codecov.io/github/yegor256/xembly.rb?branch=master)

Xembly is assembly for XML.

Read this [blog post](http://www.yegor256.com/2014/04/09/xembly-intro.html)
and check this project: [yegor256/xembly](https://github.com/yegor256/xembly)

To install, you will need Ruby 2.0+:

```bash
$ gem install xembly
```

Then, run it and read its output:

```bash
$ xembly --help
```

Say, you want to modify an existing XML document, which is in the file `doc.xml`:

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

The full specification of Xembly language is
[here](https://github.com/yegor256/xembly).
