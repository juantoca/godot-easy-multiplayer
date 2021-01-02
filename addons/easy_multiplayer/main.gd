tool
extends EditorPlugin


func _enter_tree():
    add_custom_type("MultiplayerWorld", "Node", load("res://addons/easy_multiplayer/nodos/MultiplayerWorld.gd"), preload("res://addons/easy_multiplayer/nodos/icon.png"))
    add_custom_type("MultiplayerComponent", "Node", load("res://addons/easy_multiplayer/nodos/MultiplayerComponent.gd"), preload("res://addons/easy_multiplayer/nodos/icon.png"))

func _exit_tree():
    remove_custom_type("MultiplayerWorld")
    remove_custom_type("MultiplayerComponent")
