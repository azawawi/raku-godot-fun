
```Raku

my $box = csg_box.name('Box')
my $sphere = csg_sphere.name('Sphere');
my $texture_resource = texture_resource.name('Camelia.png');

my $box = Godot::Fun::CSGBox.new.name('Box')
my $sphere = Godot::Fun::CSGSphere.new.name('Sphere');

# Raku's mascat 3D Sprite
my $texture_resource = Godot::Fun::TextureResource.new.name('Camelia.png');
my $sprite3d = Godot::Fun::Sprite3D.new(name => 'Sprite3D');
$sprite3d.texture($texture_resource);

$scene
	.add($box)
	.add($sprite3d, :tx(5);

my $texture_resource = texture_resource.name('Camelia.png');
$scene
	.add(csg-box.name('Box'))
	.add(sprite3d.name('Sprite3D').tx(5).texture($texture_resource);

# transform = Transform( -0.943089, -0.33254, 0, 0.33254, -0.943089, 0, 0, 0, 1, 0, 0, 0 )

# [sub_resource type="Animation" id=1]
# resource_name = "Anim #1"
# tracks/0/type = "value"
# tracks/0/path = NodePath("Cube:translation")
# tracks/0/interp = 1
# tracks/0/loop_wrap = true
# tracks/0/imported = false
# tracks/0/enabled = true
# tracks/0/keys = {
# "times": PoolRealArray( 0, 1 ),
# "transitions": PoolRealArray( 1, 1 ),
# "update": 0,
# "values": [ Vector3( 0, 0, 4 ), Vector3( 0, 0, -5 ) ]
# }

# [sub_resource type="Animation" id=2]
# length = 0.001
# tracks/0/type = "value"
# tracks/0/path = NodePath("Cube:translation")
# tracks/0/interp = 1
# tracks/0/loop_wrap = true
# tracks/0/imported = false
# tracks/0/enabled = true
# tracks/0/keys = {
# "times": PoolRealArray( 0 ),
# "transitions": PoolRealArray( 1 ),
# "update": 0,
# "values": [ Vector3( 0, 0, 4 ) ]
# }
```
