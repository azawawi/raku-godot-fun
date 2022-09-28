#!/usr/bin/env raku

use v6;

use Godot::Fun::Project;
use Godot::Fun::Scene;

my $project_folder = 'hello-project';

# Create 3D scene with 5 CSG Boxes
my $scene = Godot::Fun::Scene.new(name => 'Hello', type => 'Spatial');
$scene.add('Cube0' ~ $_, 'CSGBox') for 1..5;
$scene.save($project_folder);

# Create Godot project
my $project = Godot::Fun::Project.new(name => 'Hello', scene => $scene);
$project.save($project_folder);

# Open project in Godot
run 'godot', $project_folder.IO.add('project.godot');
