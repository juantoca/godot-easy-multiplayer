extends "res://addons/easy_multiplayer/nodos/MultiplayerWorld.gd"

func player_connected(id):
    var p = preload("res://Demos/Simple Movement/World/Player.tscn")
    var n = p.instance()
    n.name = str(id)
    self.add_child(n)
    n.get_node("MultiplayerComponent").set_master_wrapper(id)

func player_disconnected(id):
    self.remove_child(self.get_node(str(id)))
