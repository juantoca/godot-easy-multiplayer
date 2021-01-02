extends Sprite

func _set(property, value):
    self.get_node("MultiplayerComponent").multiplayer_set(property, value)

func _process(delta):
    if (is_network_master()):
        if Input.is_key_pressed(KEY_W):
            self.position += Vector2(0, -delta*400)
        if Input.is_key_pressed(KEY_S):
            self.position += Vector2(0, delta*400)
        if Input.is_key_pressed(KEY_A):
            self.position += Vector2(-delta*400, 0)
        if Input.is_key_pressed(KEY_D):
            self.position += Vector2(delta*400, 0)

