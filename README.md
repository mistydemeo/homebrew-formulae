Misty's formulae
================

This repository has various formulae which aren't in another fork for
some or other reason. Really nothing that exciting here!

Want to install something from here? First you need to:
```
brew tap mistydemeo/formulae
```

Formulae available
==================

twee
----

A commandline compiler for [Twine](http://gimcrackd.com/etc/src/).

pandoc
------
[pandoc](http://johnmacfarlane.net/pandoc/) is an awesome document converter that's great for converting Markdown to anything. Unfortunately it's a bit a pain to build since compiling from source requires ghc/haskell-platform and I got tired of that, so this formula installs from the official binary packages.

darktable
---------

Raw photo processing software using GTK+. I haven't had much chance to
try this yet, but was inspired to give it a go based on
[Lewis Collard's review](http://lewiscollard.com/tmp/darktable-linux-review/).
Seems to work okay but haven't tested everything yet.

Argyll CMS
----------

[Argyll](http://www.argyllcms.com/) is a colour calibration system which
allows calibration of monitors, capture equipment (such as scanners,
cameras, etc.) and printers. It can create ICC profiles for calibrated
devices.

This formula is just an installer for the binaries from the Argyll site
as a convenience, and has been minimally tested so far.

[compleat](http://limpet.net/mbrubeck/2009/10/30/compleat.html)
--------

Completion-writing tool for bash and zsh.

aview
-----

Hackily customized noninteractive version of aview, the image-to-ASCII converter. This is needed to convert videos for [hotline](https://github.com/mistydemeo/hotline).

xmdp
----

Port of Future Crew's [MusicDiskPlayer](http://www.textfiles.com/computers/DOCUMENTATION/fcinfo17.txt) to the [libxmp](http://xmp.sourceforge.net/) playback library.
