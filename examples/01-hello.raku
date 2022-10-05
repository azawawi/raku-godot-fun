#!/usr/bin/env raku

use v6;

use Godot::Fun;
use Godot::Fun::Project;
use Godot::Fun::Scene;

my $project_folder = 'hello-project';

# Create 3D scene with CSG primitives, directional light and camera

my $spatial = Godot::Fun::Spatial.new(is_root => True);
$spatial.add: Godot::Fun::CSGBox.new(name => 'Floor', ty => -1.0, material => material(grey),
    width => 20, height => 0.25, depth => 20);
$spatial.add: Godot::Fun::CSGBox.new(material => material(red));
$spatial.add: Godot::Fun::CSGCylinder.new(tx =>  5, material => material(green));
$spatial.add: Godot::Fun::CSGSphere.new(tx => -5, material => material(blue));
$spatial.add: Godot::Fun::CSGSphere.new(name => 'Small Sphere', tx => -5, ty => 2,
    radius => 0.5, material => material(dark_green));
$spatial.add: Godot::Fun::CSGTorus.new(tz => -5, material => material(yellow));
$spatial.add: Godot::Fun::CSGTorus.new(name => 'Smaller Torus', tz => -5, ty => 2,
    material => material(dark_green), inner_radius => 1, outer_radius => 2);
$spatial.add: Godot::Fun::CSGPolygon.new(tz =>  5, material => material(pink));
$spatial.add: Godot::Fun::CSGMesh.new;
$spatial.add: Godot::Fun::CSGCylinder.new(name => 'Cone', tx => 8, height => 2, cone => True,
    material => material(orange));
my $csg_combiner = Godot::Fun::CSGCombiner.new;
$csg_combiner.add: Godot::Fun::CSGBox.new(name => 'Box1', material => material(red), tx => 5,
    ty => -5, operation => Intersection);
$csg_combiner.add: Godot::Fun::CSGBox.new(name => 'Box2', material => material(green), tx => 5, ty => -4);
$spatial.add: $csg_combiner;


$spatial.add: Godot::Fun::DirectionalLight.new(shadow_enabled => True);
$spatial.add: Godot::Fun::Camera.new(tx => 2, ty => 4, tz => 11);

my $texture = Godot::Fun::TextureResource.new(
    name => "camelia.png",
    path => "res://assets/camelia.png",
);
$spatial.add: Godot::Fun::Sprite3D.new(texture => $texture, ty => 3);

my $mesh1 = Godot::Fun::ArrayMeshResource.new(
    name => "fun01.obj",
    path => "res://assets/fun01.obj",
);
$spatial.add: Godot::Fun::MeshInstance.new(name => 'MeshInstance 1', mesh => $mesh1, ty => 5);

my $mesh2 = Godot::Fun::CapsuleMeshResource.new;
$spatial.add: Godot::Fun::MeshInstance.new(name => 'CapsuleMesh', mesh => $mesh2, tx => 5, ty => 5);

my $mesh3 = Godot::Fun::CubeMeshResource.new;
$spatial.add: Godot::Fun::MeshInstance.new(name => 'CubeMesh', mesh => $mesh3, tx => -5, ty => 5);

my $mesh4 = Godot::Fun::CylinderMeshResource.new;
$spatial.add: Godot::Fun::MeshInstance.new(name => 'CylinderMesh', mesh => $mesh4, tx => 5, ty => 8);

my $scene = Godot::Fun::Scene.new: name => 'Hello', root_node => $spatial;
$scene.save: $project_folder;

# Create Godot project
my $project = Godot::Fun::Project.new: name => 'Hello From Raku!', scene => $scene;
$project.save: $project_folder;

# TODO move this to inside Godot::Fun
$project_folder.IO.add("monitor.tscn").IO.spurt(qq{
[gd_scene load_steps=2 format=2]

[ext_resource path="res://assets/monitor.glb" type="PackedScene" id=98]

[node name="monitor" instance=ExtResource( 98 )]
});

my $hello_scene = $project_folder.IO.add("Hello.tscn").slurp;
my $ext_resource = qq{[ext_resource path="res://monitor.tscn" type="PackedScene" id=99]};
my @lines = ($hello_scene.lines[0], $ext_resource, $hello_scene.lines[1..*]).flat;
$hello_scene = @lines.join("\n") ~ qq{[node name="monitor" parent="." instance=ExtResource( 99 )]\n};
$project_folder.IO.add("Hello.tscn").spurt($hello_scene);

# Open project in Godot
$project.open: $project_folder;

# Run a project in Godot
# $project.run: $project_folder;
