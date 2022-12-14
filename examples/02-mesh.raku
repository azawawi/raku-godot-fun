#!/usr/bin/env raku

use v6;

use Godot::Fun;
use Godot::Fun::Project;
use Godot::Fun::Scene;

my $project_folder = '02-mesh-project';

# Create 3D scene with CSG primitives, directional light and camera

my $spatial = Godot::Fun::Spatial.new(is_root => True);
$spatial.add: Godot::Fun::DirectionalLight.new(shadow_enabled => True);
$spatial.add: Godot::Fun::Camera.new(tx => 2, ty => 4, tz => 11);

my $mesh1 = Godot::Fun::ArrayMeshResource.new(
    name => "fun01.obj",
    path => "res://assets/fun01.obj",
);
$spatial.add: Godot::Fun::MeshInstance.new(name => 'MeshInstance 1', mesh => $mesh1, ty => 2);

my $mesh2 = Godot::Fun::CapsuleMeshResource.new;
$spatial.add: Godot::Fun::MeshInstance.new(name => 'CapsuleMesh', mesh => $mesh2, tx => 5,
    ty => 2);

my $mesh3 = Godot::Fun::CubeMeshResource.new;
$spatial.add: Godot::Fun::MeshInstance.new(name => 'CubeMesh', mesh => $mesh3, tx => -5, ty => 2);

my $mesh4 = Godot::Fun::CylinderMeshResource.new;
$spatial.add: Godot::Fun::MeshInstance.new(name => 'CylinderMesh', mesh => $mesh4, tx => 5,
    ty => 5);

my $mesh5 = Godot::Fun::PlaneMeshResource.new;
$spatial.add: Godot::Fun::MeshInstance.new(name => 'PlaneMesh', mesh => $mesh5, tx => -5, ty => 5);

#TODO PointMesh

my $mesh6 = Godot::Fun::PrismMeshResource.new;
$spatial.add: Godot::Fun::MeshInstance.new(name => 'PrismMesh', mesh => $mesh6, tx => -5, ty => 5,
    tz => -3);

my $mesh7 = Godot::Fun::QuadMeshResource.new;
$spatial.add: Godot::Fun::MeshInstance.new(name => 'QuadMesh', mesh => $mesh6, tx => 5, ty => 5,
    tz => -3);

my $mesh8 = Godot::Fun::QuadMeshResource.new;
$spatial.add: Godot::Fun::MeshInstance.new(name => 'SphereMesh', mesh => $mesh8, tx => -5, ty => 2,
tz => -3);

my $mesh9 = Godot::Fun::TextMeshResource.new;
$spatial.add: Godot::Fun::MeshInstance.new(name => 'TextMesh', mesh => $mesh9, tx => 5, ty => 2,
    tz => -3);

my $scene = Godot::Fun::Scene.new: name => 'Mesh', root_node => $spatial;
$scene.save: $project_folder;

# Create Godot project
my $project = Godot::Fun::Project.new: name => 'Mesh Example - Raku', scene => $scene;
$project.save: $project_folder;

# TODO move this to inside Godot::Fun
$project_folder.IO.add("monitor.tscn").IO.spurt(qq{
[gd_scene load_steps=2 format=2]

[ext_resource path="res://assets/monitor.glb" type="PackedScene" id=98]

[node name="monitor" instance=ExtResource( 98 )]
});

my $scene_text = $project_folder.IO.add("Mesh.tscn").slurp;
my $ext_resource = qq{[ext_resource path="res://monitor.tscn" type="PackedScene" id=99]};
my @lines = ($scene_text.lines[0], $ext_resource, $scene_text.lines[1..*]).flat;
$scene_text = @lines.join("\n") ~ qq{[node name="monitor" parent="." instance=ExtResource( 99 )]\n};
$project_folder.IO.add("Mesh.tscn").spurt($scene_text);

# Open project in Godot
$project.open: $project_folder;
