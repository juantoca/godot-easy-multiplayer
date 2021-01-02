tool
extends Node

export (Array, String) var unreliable_attributes = []

var modified_atributes = {}
var unreliable_update = {}

func _ready():
    for x in unreliable_attributes:
        unreliable_update[x] = []

remote func custom_rset(property, value):
    self.get_parent().set(property, value)

remote func custom_rset_unreliable(property, value):
    self.get_parent().set(property, value)

func multiplayer_set(property, value):
    if get_tree() != null:
        if not(property in self.unreliable_update):
            if self.get_parent().is_network_master():
                rpc("custom_rset", property, value)
            if get_tree().is_network_server():
                self.modified_atributes[property] = value
        else:
            if self.is_network_master():
                rpc_unreliable("custom_rset_unreliable", property, value)
            if get_tree().is_network_server():
                self.modified_atributes[property] = value


func sync_state_wrapper(id):
    rpc_id(id, "sync_state", self.modified_atributes)
remote func sync_state(m):
    if 1 == get_tree().get_rpc_sender_id(): # Only server can sync states
        for x in m.keys():
            self.get_parent().set(x, m[x])


func set_master_wrapper(id):
    rpc("set_master", id)
remotesync func set_master(id: int):
    if 1 == get_tree().get_rpc_sender_id(): # Only server can change masters
        self.get_parent().set_network_master(id, true)
