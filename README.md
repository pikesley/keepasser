[![Build Status](http://img.shields.io/travis/pikesley/keepasser.svg?style=flat-square)](https://travis-ci.org/pikesley/keepasser)
[![Code Climate](http://img.shields.io/codeclimate/github/pikesley/keepasser.svg?style=flat-square)](https://codeclimate.com/github/pikesley/keepasser)
[![Gem Version](http://img.shields.io/gem/v/keepasser.svg?style=flat-square)](https://rubygems.org/gems/keepasser)
[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://pikesley.mit-license.org)

# Keepasser

I use [KeePassX](https://www.keepassx.org/) on various Macbooks and my Phone, with the `.kdb` file stored in Dropbox. For reasons I can't quite fathom, these files have started to suffer what appear to be merge-conflicts, so now my Dropbox looks like this:

    keepassx (Sam P's conflicted copy) (1) (Sam P's conflicted copy).kdb
    keepassx (Sam P's conflicted copy) (1).kdb
    keepassx (Sam P's conflicted copy).kdb
    keepassx (sampi's conflicted copy 2017-12-11).kdb
    keepassx (sampi's conflicted copy 2018-01-29).kdb
    keepassx.kdb

which, I'm sure you'll agree, is upsetting for any number of reasons. These files are all intact and usable, but it means that some of my logins are an untrustworthy mess

## So, how does this help?

Well, once you've installed the gem

    git clone https://github.com/pikesley/keepasser
    cd keepasser
    bundle
    rake install

you need to:

* Open each of the `.kdb` files
* `File` > `Export to` > `Text file`
  * I used the `.kdb` name between `keepassx ` and `.kdb` for the filename
  * Yes, you now have all of your passwords on your laptop in plaintext _which is obviously a fucking terrible idea_, just remember to delete them when you're done, eh?
* Then, one at time, do `keepasser compare <trusted.kdb> <some_terrible_name.kdb>`

You should see some YAMLy output like:

    ---
    Missing entries:
      web:
      - Netflix:
        title: Netflix
        username: email@example.com
        url: ''
        password: password
        comment:
        - ''
      - all4:
        title: all4
        username: email@example.com
        url: ''
        password: password
        comment:
        - ''
      - bbc:
        title: bbc
        username: email@example.com
        url: ''
        password: password
        comment:
        - ''
      - gopro:
        title: gopro
        username: email@example.com
        url: ''
        password: password
        comment:
        - ''
    Different data:
      web:
        amazon:
          password:
          - oldpassword
          - newpassword

### Notes

* The assumption here is that `<trusted.kdb>` is your canonical database, and you're interested in tracking-down entries that are in the rogue DBs but not the `trusted` one, and adding them to `trusted`
* For the `Different data` section, I just went to the services concerned and tried each password to see which one was cromulent
* I may be the only person having this problem, of course
