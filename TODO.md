
```Raku
my $root_node = Godot::Fun::Spatial.new(name => 'Hello');

my $root_node = spatial().name('Hello');

my $scene = Godot::Fun::Scene.new(root_node => $root_node);
my $scene = scene.root_node($root_node);

# CSGBox

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

# [node name="Camera" type="Camera" parent="."]
# transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 3.5, 10.5 )

# [node name="DirectionalLight" type="DirectionalLight" parent="."]
# transform = Transform( -0.943089, -0.33254, 0, 0.33254, -0.943089, 0, 0, 0, 1, 0, 0, 0 )
# shadow_enabled = true

# $scene.add($sprite3d, :tx(5));
# $scene.add('Box', 'CSGBox');
# $scene.add('Cylinder', 'CSGCylinder', :tx(5));
# $scene.add('Sphere', 'CSGSphere', :tx(-5));
# $scene.add('Polygon', 'CSGPolygon', :tz(5));
# $scene.add('Mesh', 'CSGMesh');
# $scene.add('Torus', 'CSGTorus', :tz(-5));
$scene.save($project_folder);

```
