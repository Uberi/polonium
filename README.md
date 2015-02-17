polonium
========

Facebook Chat. Refined.

Polonium is a better desktop Facebook chat client, with a **resizable chat window**, **desktop notifications**, and more. It's somewhat similar to (and inspired by) the Mac-only [Goofy](http://www.goofyapp.com/) app.

# [CHECK IT OUT](https://github.com/Uberi/polonium/releases)

Polonium is currently available for **64-bit Windows** and **64-bit Linux**.

Features
--------

* Eggplant button.
* Native desktop notifications for Facebook messages.
* Resizable chat window with all Facebook Messaging functionality.
* Custom styling for Facebook UI.
* Easily extendable with additional functionality.
* Distraction free messaging on the desktop.

Developing
----------

First, make sure you have all the dependencies by running the following in the project root folder. The following should work for Debain-based Linux distributions:

    sudo apt-get install npm nodejs nodejs-legacy
    npm install # install all the project dependencies

Now build the project anytime by executing the following in the project root folder. This will generate binaries and packages for all supported platforms:

    ./build.sh

Output files can be found under the `dist` folder.

License
-------

Polonium is copyright Anthony Zhang, 2015, and is licensed under the MIT license. A copy is available in the `LICENSE` file in the project root folder.

NWJS is not affiliated with Polonium, and is also licensed under the MIT license.
