require 'formula'

class Twee < Formula
  homepage 'https://github.com/tweecode/twee/'
  url 'http://twee.googlecode.com/files/twee-1.7.1.zip'
  sha1 'fd9e95b6486e6cfbd20196bbad38920a50ce824e'
  head 'https://github.com/tweecode/twee.git'

  # Fixes scripts so that they find their libs regardless of where
  # the bin symlinks are installed to
  # Merged upstream
  patch :DATA unless build.head?

  def install
    libexec.install Dir['*']

    %w[twee toward untwee].each do |exec|
      # Nope, they're not +x
      chmod 0775, libexec/exec
      bin.install_symlink libexec/exec
    end
  end
end

__END__
diff --git a/toward b/toward
index dfa00af..d81cf21 100644
--- a/toward
+++ b/toward
@@ -1,7 +1,7 @@
 #!/usr/bin/env python
 
 import sys, os, getopt, glob
-scriptPath = os.path.realpath(os.path.dirname(sys.argv[0]))
+scriptPath = os.path.dirname(os.path.realpath(__file__))
 sys.path.append(scriptPath + os.sep + 'lib')
 from project import Project
 
diff --git a/twee b/twee
index f25825f..7d72fe5 100644
--- a/twee
+++ b/twee
@@ -1,7 +1,7 @@
 #!/usr/bin/env python
 
 import sys, os, getopt, glob
-scriptPath = os.path.realpath(os.path.dirname(sys.argv[0]))
+scriptPath = os.path.dirname(os.path.realpath(__file__))
 sys.path.append(scriptPath + os.sep + 'lib')
 from tiddlywiki import TiddlyWiki
 
diff --git a/untwee b/untwee
index 1f2a7ec..71745fb 100644
--- a/untwee
+++ b/untwee
@@ -1,7 +1,8 @@
 #!/usr/bin/env python
 
 import sys, os
-sys.path.append(os.getcwd() + os.sep + 'lib')
+scriptPath = os.path.dirname(os.path.realpath(__file__))
+sys.path.append(scriptPath + os.sep + 'lib')
 from tiddlywiki import TiddlyWiki
 
 def usage():
