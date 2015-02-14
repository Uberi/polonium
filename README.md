polonium
========

Facebook Chat. Refined.

Polonium is a better desktop Facebook chat client, with a resizable chat window, desktop notifications, and more. It's somewhat similar to the Mac-only [Goofy](http://www.goofyapp.com/) app.

;wip: make downloads

Developing
----------

First, make sure you have all the dependencies by running the following in the project root folder. The following should work for Debain-based Linux distributions:

    sudo apt-get install npm nodejs nodejs-legacy
    sudo npm install -g grunt
    npm install # install all the project dependencies

Now build the project anytime by executing one of the following in the project root folder, as necessary:

    grunt dist-linux
    grunt dist-linux32
    grunt dist-win
    grunt dist-mac
    grunt dist-mac32
    grunt dmg # this will only work on OS X

Output files can be found under the `dist` folder.
