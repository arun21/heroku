Heroku CLI
==========

The Heroku CLI is used to manage Heroku apps from the command line.

For more about Heroku see <http://heroku.com>.

To get started see <http://devcenter.heroku.com/articles/quickstart>

[![Build Status](https://travis-ci.org/heroku/heroku.svg?branch=master)](https://travis-ci.org/heroku/heroku)
[![Build status](https://ci.appveyor.com/api/projects/status/kv0r2s5eyckpanhr/branch/master)](https://ci.appveyor.com/project/dickeyxxx/heroku/branch/master)
[![Coverage Status](https://img.shields.io/coveralls/heroku/heroku.svg)](https://coveralls.io/r/heroku/heroku?branch=master)
[![Dependency Status](https://gemnasium.com/heroku/heroku.svg)](https://gemnasium.com/heroku/heroku)

Setup
-----

<table>
  <tr>
    <th>If you have...</th>
    <th>Install with...</th>
  </tr>
  <tr>
    <td>Mac OS X</td>
    <td style="text-align: left"><a href="http://toolbelt.herokuapp.com/osx/download">Download OS X package</a></td>
  </tr>
  <tr>
    <td>Windows</td>
    <td style="text-align: left"><a href="http://toolbelt.herokuapp.com/windows/download">Download Windows .exe installer</a></td>
  </tr>
  <tr>
    <td>Ubuntu Linux</td>
    <td style="text-align: left"><a href="http://toolbelt.herokuapp.com/linux/readme"><code>apt-get</code> repository</a></td>
  </tr>
  <tr>
    <td>Other</td>
    <td style="text-align: left"><a href="http://assets.heroku.com/heroku-client/heroku-client.tgz">Tarball</a> (add contents to your <code>$PATH</code>)</td>
  </tr>
</table>

Once installed, you'll have access to the `heroku` command from your command shell.  Log in using the email address and password you used when creating your Heroku account:

    $ heroku login
    Enter your Heroku credentials.
    Email: adam@example.com
    Password:
    Could not find an existing public key.
    Would you like to generate one? [Yn]
    Generating new SSH public key.
    Uploading SSH public key /Users/adam/.ssh/id_rsa.pub

Press enter at the prompt to upload your existing `SSH` key or create a new one, used for pushing code later on.

API
---

For additional information about the API see [Heroku API Quickstart](https://devcenter.heroku.com/articles/platform-api-quickstart) and [Heroku API Reference](https://devcenter.heroku.com/articles/platform-api-reference).

Development
-----------

If you're working on the CLI and you can smoke-test your changes:

    $ bundle exec heroku

Meta
----

Released under the MIT license; see the file License.

Created by Adam Wiggins

[Other Contributors](https://github.com/heroku/heroku/contributors)
