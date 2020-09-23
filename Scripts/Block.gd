extends CollisionShape2D

var sprite

func _ready():
	self.sprite = $Sprite


#func _process(delta):
#	pass

func destroy():
	hide()
	queue_free()
