
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

# [ext_resource path="res://camelia_icon.png" type="Texture" id=1]
# [node name="Sprite3D" type="Sprite3D" parent="."]
# texture = ExtResource( 1 )

# [node name="DirectionalLight" type="DirectionalLight" parent="."]
# transform = Transform( -0.943089, -0.33254, 0, 0.33254, -0.943089, 0, 0, 0, 1, 0, 0, 0 )
# shadow_enabled = true

```
