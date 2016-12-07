# Overview

Welcome to the realtime, distributed, web-technology oriented SCADA system for Industrial usage. The SCADA system focuses on fast development and cross-platform (cross-browser and mobile) compatibility.


# Key features

* First-class support for [LiveScript](http://livescript.net) with Sourcemaps!
* Supports [Ractive.js](http://ractivejs.com) with a [custom component mechanizm](./src/client/components)
* Supports [Pug](https://pugjs.org) for composing html documents
* Uses Distributed NoSQL database ([CouchDB](http://couchdb.apache.org/) in mind)
* Supports variety of network and industrial protocol [servers](./src/server), including
    * http
    * websockets
    * long-polling
    * Modbus
    * etc...
* Fully compatible with [aktos-dcs (Python)](https://github.com/aktos-io/aktos-dcs), [aktos-dcs-cs (C# port)](https://github.com/aktos-io/aktos-dcs-cs), [aktos-dcs-js (Node.js port)](https://github.com/aktos-io/aktos-dcs-js) libraries, a message passing distributed control system library by [aktos.io](https://aktos.io).
* Supports tools and documentation for [DRY](https://en.wikipedia.org/wiki/Don't_repeat_yourself) and [TDD](https://en.wikipedia.org/wiki/Test-driven_development) in mind.
* Provides build system via [Gulp](http://gulpjs.com).

# INSTALL

Install all dependencies:

    git clone {{ scada }}
    cd {{ scada }}
    npm install

# Running example

See [`./apps/example/README.md`](./apps/example/README.md).

# Updating

    git pull origin master
    git submodule update --recursive

# Starting a New Project

You can start a new project by simply copying [`./apps/example`](./apps/example) as `./apps/myproject` or create project layout by scratch:

=======

1. Create your project directory (eg. `myproject`) in `{{ scada }}/apps`
2. Place any README, scripts and source codes in your project directory.
3. Place your browser applications (webapps) in `{{ myproject }}/webapps` directory
4. Start Gulp by passing your project name as parameter: `gulp --project=myproject`
5. The browser applications (`.html`, `.js` and `.css` files) will be created under `{{ scada }}/build/public` directory

Directory structure is as follows:

```
{{ scada }}
├── apps
│   ├── example
│   │   ├── README.md
│   │   ├── my-custom-script.sh
│   │   ├── webapps
│   │   │   └── showcase
│   │   │       ├── index.pug (the html file to be served to the client)
│   │   │       ...
│   │   │       └── showcase.ls   (main js file (entry point))
│   │   └── webserver
│   │       └── server.ls (webserver for this app)
...
```

**Rest of Directory Structure as follows: **


```
...
├── README.md
├── gulpfile.ls
├── package.json
├── build (temporary build directory, may be deleted at any time)
│   └── public
│       ├── showcase.html
│       ├── showcase.js
│       ├── css
│       │   └── vendor.css
│       ├── js
│       │   └── vendor.js
│       ...
├── src
│   ├── client
│   │   ├── assets (files that are directly copied to {{ scada }}/build/public
│   │   ├── components (Ractive Components)
│   │   └── templates (Pug stuff)
│   │       ...
│   └── lib
│       ... (Libraries used in both server and browser)
└── vendor (Vendor specific js and css files, like Ractive, jQuery, Bootstrap...)
    ├── 000.jquery
    │   └── jquery-1.12.0.min.js
    ├── 000.ractive
    │   └── ractive.js
    ... (prefixes are used to determine concatenation order)
```

# TODO/ROADMAP

* Add native mobile app support via Service Worker
* Add OPC support
