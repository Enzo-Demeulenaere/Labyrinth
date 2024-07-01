Class {
	#name : 'LItem',
	#superclass : 'Object',
	#instVars : [
		'name'
	],
	#category : 'Labyrinth-Model',
	#package : 'Labyrinth',
	#tag : 'Model'
}

{ #category : 'accessing' }
LItem class >> name: aString [ 

	^ self new name: aString
]

{ #category : 'accessing' }
LItem >> icon [ 

	^ LRessources perform: ((name , 'Icon') asSymbol)
]

{ #category : 'accessing' }
LItem >> name [ 

	^ name 
	

]

{ #category : 'accessing' }
LItem >> name: aString [

	name := aString
]
