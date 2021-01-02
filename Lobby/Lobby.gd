extends CenterContainer

export (int) var port
export (int) var players

func get_port():
    return port

func get_players():
    return players

func get_ip():
    return $"Ventana Conexión/Entrada IP/LineEdit".text

func _on_Host_pressed():
    var peer = NetworkedMultiplayerENet.new()
    peer.create_server(get_port(), get_players())
    get_tree().set_network_peer(peer)
    get_tree().change_scene("res://World/World.tscn")
    print("Soy el servidor")


func _on_Client_pressed():
    var peer = NetworkedMultiplayerENet.new()
    peer.create_client($"Ventana Conexión/Entrada IP/LineEdit".text, get_port())
    get_tree().network_peer = peer
    get_tree().change_scene("res://World/World.tscn")
    print("Conectado")
