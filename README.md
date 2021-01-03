# godot-easy-multiplayer
An atempt at creating an easy-to-use ultra-high level multiplayer API with GDScript. Performance isn't a priority 

## Installation

Clone the repo and move the folder addons/easy_multiplayer to the addons folder of your project according to the official docs: 
https://docs.godotengine.org/en/stable/tutorials/plugins/editor/installing_plugins.html

## Architecture and usage

This plugin is based upon 2 nodes:

* *MultiplayerComponent*: When attached as a child node, takes care of syncronizing parents state with all the connected peers by overwriting the _set() method.
   * Can be extended to modify the way it syncs(for example, an interpolation of UDP updates can be implemented by extending this base node)
   * It also implements a way to sync the parents node with a new player entering the game

* *MultiplayerWorld*: Node that defines a game instance(for example, this node would be the equivalent to an Starcraft match or an EVE online solar system), 
it captures all multiplayer signals and take care of syncing game state with new players. In case server creates/destroys a child node, it will take care 
to do the same in all connected peers  


