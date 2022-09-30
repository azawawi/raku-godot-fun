#!/usr/bin/env raku

use v6;

use Godot::Fun;
use Godot::Fun::Project;
use Godot::Fun::Scene;

my $project_folder = 'hello-project';

# Create 3D scene with CSG primitives, directional light and camera

my $spatial = Godot::Fun::Spatial.new;
my $red = Godot::Fun::Color.new(red => 1);
my $green = Godot::Fun::Color.new(green => 1);
my $blue = Godot::Fun::Color.new(blue => 1);
my $yellow = Godot::Fun::Color.new(red => 1, green => 1);
my $pink = Godot::Fun::Color.new(red => 1, blue => 1);
my $grey = Godot::Fun::Color.new(red => 0.5, green => 0.5, blue => 0.5);
my $red_material = Godot::Fun::SpatialMaterial.new(albedo_color => $red);
my $green_material = Godot::Fun::SpatialMaterial.new(albedo_color => $blue);
my $blue_material = Godot::Fun::SpatialMaterial.new(albedo_color => $green);
my $yellow_material = Godot::Fun::SpatialMaterial.new(albedo_color => $yellow);
my $pink_material = Godot::Fun::SpatialMaterial.new(albedo_color => $pink);
my $grey_material = Godot::Fun::SpatialMaterial.new(albedo_color => $grey);
$spatial.add: Godot::Fun::CSGBox.new(name => 'Floor', ty => -1.0, material => $grey_material,
    width => 20, height => 0.25, depth => 20);
$spatial.add: Godot::Fun::CSGBox.new(material => $red_material);
$spatial.add: Godot::Fun::CSGCylinder.new(tx =>  5, material => $green_material);
$spatial.add: Godot::Fun::CSGSphere.new(tx => -5, material => $blue_material);
$spatial.add: Godot::Fun::CSGTorus.new(tz => -5, material => $yellow_material);
$spatial.add: Godot::Fun::CSGPolygon.new(tz =>  5, material => $pink_material);
$spatial.add: Godot::Fun::CSGMesh.new;
$spatial.add: Godot::Fun::CSGCombiner.new;
$spatial.add: Godot::Fun::DirectionalLight.new(shadow_enabled => True);
$spatial.add: Godot::Fun::Camera.new(ty => 3.5, tz => 10.5);

my $texture = Godot::Fun::TextureResource.new(
    name => "camelia.png",
    path => "res://assets/camelia.png",
);
$spatial.add: Godot::Fun::Sprite3D.new(texture => $texture, ty => 3);

my $scene = Godot::Fun::Scene.new: name => 'Hello', root_node => $spatial;
$scene.add($texture);
$scene.add($red_material);
$scene.add($green_material);
$scene.add($blue_material);
$scene.add($yellow_material);
$scene.add($pink_material);
$scene.add($grey_material);
$scene.save: $project_folder;

# Create Godot project
my $project = Godot::Fun::Project.new: name => 'Hello From Raku!', scene => $scene;
$project.save: $project_folder;

# Open project in Godot
run 'godot', $project_folder.IO.add: 'project.godot';
