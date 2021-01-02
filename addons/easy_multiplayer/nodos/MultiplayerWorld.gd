tool
extends Node

# Child scenes must have a MultiplayerComponent as a child that implements:
# sync_state_wrapper()
# multiplayer_set()
# set_master_wrapper()
# They must also call multiplayer_set() in _set()

const mp_component_name = "MultiplayerComponent"

func _ready():
    get_tree().connect("network_peer_connected", self, "_on_peer_connected")
    get_tree().connect("network_peer_disconnected", self, "_on_peer_disconnected")
    get_tree().connect("node_added", self, "_on_node_added")
    get_tree().connect("node_removed", self, "_on_node_removed")
    
    
func _on_peer_disconnected(id):
    if(get_tree().is_network_server()):
        rpc("toggle_pause")
        player_disconnected(id)
        rpc("toggle_pause")
        
func _on_peer_connected(id):
    if(get_tree().is_network_server()):
        rpc("toggle_pause")
        self.sync_state(id)
        self.player_connected(id)
        rpc("toggle_pause")

remote func toggle_pause():
    if 1 == get_tree().get_rpc_sender_id(): # Only server can pause game
        get_tree().paused = !get_tree().paused

func player_connected(id):
    pass

func player_disconnected(id):
    pass

func _on_node_added(n):
    if(self.is_network_master()):
        var clas = n.get_class()
        var p = self.get_path_to(n.get_parent())
        rpc("create_node", n.filename, p, n.name)

func _on_node_removed(n):
    if get_tree():
        if(get_tree().is_network_server()):
            var p = self.get_path_to(n)
            rpc("remove_node", p)

func sync_state_helper(id: int, node):
    if node.filename != "":
        var p = self.get_path_to(node.get_parent())
        rpc_id(id, "create_node", node.filename, p, node.name)
    if node.name == "MultiplayerComponent":
        node.sync_state_wrapper(id)
    for x in node.get_children():
        self.sync_state_helper(id, x)

func sync_state(id: int):
    for x in self.get_children():
        sync_state_helper(id, x)

remote func create_node(path_filename: String, path: String, name: String):
    if 1 == get_tree().get_rpc_sender_id(): # Only server can create nodes
        var n = load(path_filename).instance()
        n.name = name
        var p = self.get_node(path)
        if p.get_node_or_null(n.name) == null:
            p.add_child(n)

remote func remove_node(path: String):
    if 1 == get_tree().get_rpc_sender_id(): # Only server can remove nodes
        var n = self.get_node(path)
        n.queue_free()

