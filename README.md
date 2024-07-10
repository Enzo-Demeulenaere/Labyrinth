# Labyrinth 

This project is an implementation of the labyrinth board game in Pharo using Bloc for the visuals.

This was at first a personnal project that became a side project during my apprenticeship at Evref team at Inria Lille, this project was then aimed to be presented at ESUG 2024  

## Loading the project

you can load the project executing this snippet in pharo 11/12:

```st
Author fullName: 'No'.
Metacello new
	repository: 'github://Enzo-Demeulenaere/Labyrinth/src';
	baseline: 'Labyrinth';
	onConflictUseLoaded;
	load.
```

In order to play, you then have to execute 
```st
LGame nbPlayers: n
```

`n` being the number of players you want to play with going from 2 to 4


## State of the project

The project is currently in a first stable version playable from 2 to 4 local players on the same computer.

A future iteration might take the project to another level by implementing a server and making the game playable online by hosting a server for friends to play.

