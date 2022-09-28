#!/usr/bin/env raku

use v6;

use Godot::Fun::Project;
use Godot::Fun::Scene;

# Generate project.godot

my $project_name = 'Hello';
my $main_scene_name = 'res://Hello.tscn';

# Generate default_env.tres
my $default_env = qq{
[gd_resource type="Environment" load_steps=2 format=2]

[sub_resource type="ProceduralSky" id=1]

[resource]
background_mode = 2
background_sky = SubResource( 1 )
};


my $filename = 'default_env.tres';
$filename.IO.spurt($default_env);
say "Wrote '$filename'";

my $scene = Godot::Fun::Scene.new(name => 'Hello', type => 'Spatial');
$scene.add('Cube0' ~ $_, 'CSGBox') for 1..5;

my $project = Godot::Fun::Project.new(name => 'Hello', scene => $scene);

$filename = 'project.godot';
$filename.IO.spurt($project.to-str);
say "Wrote '$filename'";
$filename = "Hello.tscn";
$filename.IO.spurt($scene.to-str);
say "Wrote '$filename'";
