#!/usr/bin/env raku

use v6;

use Godot::Fun;
use Godot::Fun::Project;
use Godot::Fun::Scene;

my $project_folder = 'hello-project';

# Create 3D scene with CSG primitives, directional light and camera
my $spatial = Godot::Fun::Spatial.new;
$spatial.add: Godot::Fun::CSGBox.new;
$spatial.add: Godot::Fun::CSGCylinder.new(tx =>  5);
$spatial.add: Godot::Fun::CSGSphere.new(tx => -5);
$spatial.add: Godot::Fun::CSGPolygon.new(tz =>  5);
$spatial.add: Godot::Fun::CSGMesh.new;
$spatial.add: Godot::Fun::CSGTorus.new(tz => -5);
$spatial.add: Godot::Fun::CSGCombiner.new;
$spatial.add: Godot::Fun::DirectionalLight.new;
$spatial.add: Godot::Fun::Camera.new(ty => 3.5, tz => 10.5);

my $texture = Godot::Fun::TextureResource.new(
    name => "camelia.png",
    path => "res://assets/camelia.png",
    id => 1
);
$spatial.add: Godot::Fun::Sprite3D.new(texture => $texture, ty => 3);

my $scene = Godot::Fun::Scene.new: name => 'Hello', root_node => $spatial;
$scene.add($texture);
$scene.save: $project_folder;

# Create Godot project
my $project = Godot::Fun::Project.new: name => 'Hello From Raku!', scene => $scene;
$project.save: $project_folder;

# Copy assets
my $assets_folder = $project_folder.IO.add("assets");
$assets_folder.mkdir;
$*PROGRAM.dirname.IO.add("assets").add("camelia.png").IO.copy($assets_folder.add("camelia.png"));

# Open project in Godot
run 'godot', $project_folder.IO.add: 'project.godot';
