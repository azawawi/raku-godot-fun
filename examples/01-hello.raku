#!/usr/bin/env raku

use v6;

use Godot::Fun::Project;
use Godot::Fun::Scene;

my $project_folder = 'hello-project';

# Create 3D scene with CSG primitives
my $scene = Godot::Fun::Scene.new(name => 'Hello', type => 'Spatial');
$scene.add('Box', 'CSGBox');
$scene.add('Cylinder', 'CSGCylinder', :tx(5));
$scene.add('Sphere', 'CSGSphere', :tx(-5));
$scene.add('Polygon', 'CSGPolygon', :tz(5));
$scene.add('Mesh', 'CSGMesh');
$scene.add('Torus', 'CSGTorus', :tz(-5));
$scene.save($project_folder);

# Create Godot project
my $project = Godot::Fun::Project.new(name => 'Hello', scene => $scene);
$project.save($project_folder);

# Open project in Godot
run 'godot', $project_folder.IO.add('project.godot');
