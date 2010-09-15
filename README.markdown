
                     s         s
      .uef^"        :8        :8      ..
    :d88E          .88       .88     @L
    `888E         :888ooo   :888ooo 9888i   .dL
     888E .z8k -*8888888 -*8888888 `Y888k:*888.
     888E~?888L  8888      8888      888E  888I
     888E  888E  8888      8888      888E  888I
     888E  888E  8888      8888      888E  888I
     888E  888E .8888Lu=  .8888Lu=   888E  888I
     888E  888E ^%888*    ^%888*    x888N><888'
    m888N= 888>   'Y"       'Y"      "88"  888
     `Y"   888   __  .__                  88F
          J88" _/  |_|  |__   ____       98"
          @%   \   __\  |  \_/ __ \    ./"
        :"      |  | |   Y  \  ___/   ~`
                |__| |___|  /\___  >
                __________\/_____\/____________________
               /   |   \__    ___/\__    ___/\______   \
              /    ~    \|    |     |    |    |     ___/
              \    Y    /|    |     |    |    |    |
               \___|_  / |____|     |____|    |____|
               ______\/___________________.___.
               \__    ___/\__    ___/\__  |   |
                 |    |     |    |    /   |   |
                 |    |     |    |    \____   |
                 |____|     |____|    / ______|
                                      \/

[htty](http://htty.github.com) is a console application for interacting with HTTP servers. It’s something of a cross between _curl_ and the Lynx browser.

Installation
============

It couldn’t be much easier.

    $ gem install htty

You’ll need Ruby and RubyGems. It’s known to work well under OS X against Ruby v1.8.7 and v1.9.2.

Features
========

* Intuitive commands and command aliases
* Support for familiar HTTP methods _GET_, _POST_, _PUT_, and _DELETE_, as well as _HEAD_, _OPTIONS_ and _TRACE_
* Support for HTTP Secure connections and HTTP Basic Authentication
* Automatic URL-encoding of userinfo, query-string parameters, and URL fragments
* Transcripts, both verbose and summary
* Dead-simple cookie handling and redirect following
* Built-in help

The things you can do with _htty_ are:

* **Build a request** — you can tweak the address, headers, cookies, and body at will
* **Send the request to the server** — after the request is sent, it remains unchanged in your session history
* **Inspect the server’s response** — you can look at the status, headers, cookies, and body in various ways
* **Review history** — a normal and a verbose transcript of your session are available at all times (destroyed when you quit _htty_)
* **Reuse previous requests** — you can refer to prior requests and copy them

Examples
========

Here are a few annotated _htty_ session transcripts to get you started.

Querying a web service
----------------------

This simple example shows how to explore read-only web services with _htty_.

![ESV Bible Web Service example #1](http://htty.github.com/images/esvapi1.png)

You can point _htty_ at a complete or partial web URL. If you don’t supply a URL, http://0.0.0.0/ (port 80) will be used. You can vary the protocol scheme, userinfo, host, port, path, query string, and fragment as you wish.

The _htty_ shell prompt shows the address of the current request.

The `get` command is one of seven HTTP request methods supported. A concise summary of the response is shown when you issue a request.

You can follow redirects using the `follow` command.

![ESV Bible Web Service example #2](http://htty.github.com/images/esvapi2.png)

You can tweak segments of the address at will. Here we are navigating the site’s path hierarchy, which you can do with relative as well as absolute pathspecs.

![ESV Bible Web Service example #3](http://htty.github.com/images/esvapi3.png)

Here we add query-string parameters. Notice that characters that require URL encoding are automatically URL-encoded (unless they are part of a URL-encoded expression).

The `headers-response` and `body-response` commands reveal the details of a response.

![ESV Bible Web Service example #4](http://htty.github.com/images/esvapi4.png)

There was some cruft in the web service’s response (a horizontal line, a passage reference, verse numbers, a copyright stamp, and line breaks). We eliminate it by using API options provided by the web service we’re talking to.

We do a Julia Child maneuver and use the `address` command to change the entire URL, rather than add individual query-string parameters one by one.

Exit your session at any time by typing `quit`.

Working with cookies
--------------------

The next example demonstrates _htty_’s cookies features, as well as how to review and revisit past requests.

![Google example #1](http://htty.github.com/images/google1.png)

Notice that when cookies are offered in a response, a bold asterisk (it looks like a cookie) appears in the response summary. The same cookie symbol appears next to the _Set-Cookie_ header when you display response headers.

![Google example #2](http://htty.github.com/images/google2.png)

The `cookies-use` command copies cookies out of the response into the next request. The cookie symbol appears next to the _Cookie_ header when you display request headers.

![Google example #3](http://htty.github.com/images/google3.png)

An abbreviated history is available through the `history` command. Information about requests in the history includes request method, URL, number of headers (and a cookie symbol, if cookies were sent), and the size of the body. Information about responses in the history includes response code, number of headers (and a cookie symbol, if cookies were received), and the size of the body.

Note that history contains only numbered HTTP request and response pairs, not a record of all the commands you enter.

The `reuse` command makes a copy of the headers and body of an earlier request for you to build on.

Understanding complex HTTP conversations at a glance using history
------------------------------------------------------------------

Assume that we have the following Sinatra application listening on Sinatra’s default port, 4567.

    require 'sinatra'

    get '/all-good' do
      [200, [['Set-Cookie', 'foo=bar; baz']], 'Hello World!']
    end

    get '/huh' do
      [404, 'What?']
    end

    get '/hurl' do
      [500, 'Barf!']
    end

    post '/give-it-to-me' do
      redirect '/all-good'
    end

This application expects _GET_ and _POST_ requests and responds in various contrived ways.

![Sinatra application example #1](http://htty.github.com/images/sinatra1.png)

Here you can see a request body being specified. Type `body-set` to enter body data, and terminate it by typing Return three times consecutively.

Also note how different response codes are rendered:

* Response codes between 200 and 299 appear <span style="background-color: green; color: black; font-weight: bold; padding: 0 0.25em 0 0.25em;">black on green</span> to indicate success
* Response codes between 300 and 399 appear <span style="background-color: blue; color: white; font-weight: bold; padding: 0 0.25em 0 0.25em;">white on blue</span> to indicate redirection
* Response codes between 400 and 499 appear <span style="background-color: red; color: white; font-weight: bold; padding: 0 0.25em 0 0.25em;">white on red</span> to indicate failure
* Response codes between 500 and 599 appear <span style="background-color: yellow; color: black; font-weight: bold; padding: 0 0.25em 0 0.25em; text-decoration: blink;">flashing black on yellow</span> to indicate a server error

![Sinatra application example #2](http://htty.github.com/images/sinatra2.png)

As with the abbreviated history demonstrated earlier, verbose history shows a numbered list of requests and the responses they elicited. All information exchanged between client and server is shown.

Getting help
------------

You can learn how to use _htty_ commands from within _htty_.

![htty’s built-in help](http://htty.github.com/images/help.png)

The `help` command takes an optional argument of the abbreviated or full name of a command.

Coming soon
===========

Here are some features that are coming down the pike.

Commands for streamlining web form submission
---------------------------------------------

These features will make _htty_ better at screen-scraping.

Using any of the forthcoming `form` commands will clear any non-form content in the body of the request. Adding at least one URL-encoded form parameter to the request will set the _Content-Type_ header to _application/x-www-form-urlencoded_. Removing all URL-encoded form parameters will remove this header.

* `form` — display all form parameters offered in the response
* `form-fill` — prompt in turn for a value for each of the form inputs in the response
* <code>form-add _name_ _value_</code> — add a URL-encoded form parameter for the request, using the specified name and value
* <code>form-remove _name_</code> — remove a URL-encoded form parameter from the request, using the specified name
* `form-remove-all` — remove all URL-encoded form parameters from the request

You will also be able to pop open a browser window containing request and response bodies.

Shiny autocomplete goodness
---------------------------

We’ll have command command autocompletion, and possibly also Tab key navigation of forms.

Custom command aliases and shell emulation of _http-console_
------------------------------------------------------------

You should be able to make your own command aliases.

_http-console_ has a nice command-line. We should have an _http-console_ skin for _htty_.

Contributing
============

Report defects and feature requests on [GitHub Issues](http://github.com/htty/htty/issues).

Your patches are welcome, and you will receive attribution here for good stuff. Fork [the official _htty_ repository](http://github.com/htty/htty "htty’s ‘htty’ repository at GitHub") and send a pull request.

News and information
====================

Stay in touch with the _htty_ project by following [@get_htty](http://twitter.com/get_htty "get_htty at Twitter") on Twitter.

You can also get help in the [#htty channel on Freenode](http://webchat.freenode.net/?channels=htty).

Credits
=======

The author, [Nils Jonsson](mailto:htty@nilsjonsson.com), owes a debt of inspiration to the [_http-console_](http://github.com/cloudhead/http-console) project.

Thanks to contributors:

* Bo Frederiksen ([bofrede](http://github.com/bofrede "bofrede at GitHub")) for work on the CLI
* Robert Pitts ([rbxbx](http://github.com/rbxbx "rbxbx at GitHub")) for work on the CLI and on RSpec specs

License
=======

Released under the [MIT License](http://htty.github.com/file.MIT-LICENSE.html).