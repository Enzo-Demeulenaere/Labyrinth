Class {
	#name : #BaselineOfLabyrinth,
	#superclass : #BaselineOf,
	#category : #BaselineOfLabyrinth
}

{ #category : #baselines }
BaselineOfLabyrinth >> baseline: spec [

	<baseline>
	spec
		baseline: 'Myg'
		with: [ spec repository: 'github://Ducasse/Myg:dev/src' ].

	spec
		package: 'Labyrinth'
		with: [ spec requires: #( 'Myg') ]
]
