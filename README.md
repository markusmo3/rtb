rtb
===

Revive The Beast : : Feed-The-Beast Minecraft Server Monitor &amp; Automated Backup

This is meant to be a simple bash script to check to see if FTB is running and launch it if it's not.  In the event of a server crash, it should notice that the server is no longer running, then start it up again to minimize downtime if the person hosting the game isn't available to restart it immediately.

It can also perform backups of the server on set intervals to the /backup directory within the FTB directory.  Defaults to a backup every 4 hours. (14400 seconds)


Limitations: 
  Currently, when you run the command initially you will be able to input commands into the console via terminal.  However, if the server crashes, the monitor will then run the next instance of the server in the background, thus you won't be able to input into it directly unless you restart the server.
  This only affects people who have no GUI and are running FTB from a terminal-only setup.  People who have access to the GUI should have no problems inputting commands into the server status window.

To-Do: 
  Configurable backup path
  Ability to turn off backups
  Ability to set number of backups to retain.
  Daily/Weekly/Monthly backup options.