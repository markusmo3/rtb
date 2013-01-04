rtb
===

Revive The Beast : : Feed-The-Beast Minecraft Server Monitor &amp; Automated Backup

This is meant to be a simple bash script to check to see if FTB is running and launch it if it's not.  In the event of a server crash, it should notice that the server is no longer running, then start it up again to minimize downtime if the person hosting the game isn't available to restart it immediately.

Some requirements: 

  Inotify Tools: https://github.com/rvoicilas/inotify-tools/wiki
  
  Screen: Should be installable through pretty much any package manager.  yum/apt-get/aptitude install screen

Usage:
       $  bash /path/to/rtb.sh
  This will set up the watcher script and inotifywait to watch for crashes/failures, plus will start the server initially.
  The server itself will run in screen, so you can use 'screen -ls' to show current screens and 'screen -x' to connect to the running screen.
    (Note, if there's more than one running screen, just add the PID after the -x)
  To detatch from the screen and go drop back into terminal, hit Ctrl+A, then Ctrl+D to detach.
  
It can also perform backups of the server on set intervals to the /backup directory within the FTB directory.  Defaults to a backup every 4 hours. (14400 seconds)


Changes: 
  2012/12/10
  * Can configure custom backup locations (to dropbox, maybe?)
  * Can set backup retention time in days (default 15 days)
  * Fixed a bug where it would fail to back up if the backup dir wasn't already created.
  * Added an extended options function for the backups.  Nothing in it yet, but it's there.
  2013/01/04
  * Now runs the server in screen so that you can always use "screen -x" to connect to the screen and input commands.
  * Uses inotifywait to watch for changes to the crash-reports folder, kills and restarts server if crash is detected.

To-Do: 
* Ability to turn off backups.
* Daily/Weekly/Monthly backup options.
* Logging of crashes/backup events.
* Easy way to stop the script without having to kill the rtb.sh and inotifywait commands manually.
