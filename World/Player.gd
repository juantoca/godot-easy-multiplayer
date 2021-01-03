extends Sprite

func _set(property, value):
    self.get_node("MultiplayerComponent").multiplayer_set(property, value)

remote func create_child():
    var n = preload("res://World/SpriteScene.tscn").instance()
    self.add_child(n)
    n.position += Vector2(30, 0)

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
        if Input.is_key_pressed(KEY_SPACE):
            rpc_id(1, "create_child")
