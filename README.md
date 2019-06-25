# TnCongress

Welcome to TnCongress! This gem is a CLI directory of all Congresspeople in the state of Tennessee which pulls data from the members directory of "http://www.capitol.tn.gov". You will be able to learn more about representatives in the House and Senate, including biographical information and/or recent bills they have sponsored.

## Installation & Starting the Program

**If you have git installed on your computer,** click the "clone or download" button at the top of this page, then copy the URL to your clipboard. Then, open a terminal and execute the following commands:

    $ git clone (paste url here)
    $ cd tn_congress

**If you do not have git installed:**
  * Click the "clone or download" button at the top of this page, then click "download zip"
  * Double click the download to unzip the files
  * Open a terminal by pressing command - spacebar, then type "terminal" and double click the search result

In the terminal window that opens, type the following command then press enter:

    $ cd downloads/tn_congress

**To start the program,** first install the dependencies by typing the following command in the terminal:

    $ bundle install

Then type the following command to run the program:

    $ ./bin/tn_congress

## Usage

Once the program starts, it will ask for information about which branch of Congress you're interested in (House, Senate, or All) and which party (D, R, or All). Next, it will display a list of members with contact information, sorted alphabetically and filtered by your selection choices. You will then have the option to learn more about any member from the list by typing in their number in the list, and choosing "bio" or "bills". If there's another representative you'd like information about, type "again", or type "exit" to end the program.
