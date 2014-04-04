IntEnv
======

test using the twitter stream api

This is a simple app that uses the Social and Accounts framework to connect to twitter. 
The app can only be run on a device that has a twitter account set up.

It keeps a connection open to the twitter api and gets the latest tweets on the keyword 'banking' and displays them.
By default, only a maximum of 10 tweets are shown on the screen. If a new one comes in, the oldest gets removed.
