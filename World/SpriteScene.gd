extends Sprite


func _set(property, value):
    self.get_node("MultiplayerComponent").multiplayer_set(property, value)
