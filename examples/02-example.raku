#!/usr/bin/env raku

use v6;

use Godot::Fun::Project;
use Godot::Fun::Scene;

my $project_folder = 'hello-project';

my $scene = Godot::Fun::Scene.new(name => 'Hello', type => 'Spatial');
$scene.add('Cube0' ~ $_, 'CSGBox') for 1..5;
$scene.save($project_folder);

my $project = Godot::Fun::Project.new(name => 'Hello', scene => $scene);
$project.save($project_folder);
