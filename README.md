# Server-Shutdown-on-failed-ping

A simple Powershell script to shutdown a server if another shuts down, e.g. one is connected to a UPS for safe shutdown and another is not.

This script is to be run on the second server and will ping the first server connected to the UPS, after 3 consecutive failed pings it will initiate a shutdown.

To run in Task sheduler use the following (this assumes the script is in the root of C drive)

Program/script
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe

Add arguments (optional)
-ExecutionPolicy Bypass -file "C:\ShutdownServer2.ps1"
