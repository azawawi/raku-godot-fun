#!/usr/bin/env raku

use v6;
use Godot::Fun;

say "More fun with Godot to come";

=begin stash
use Godot::Fun;

my $editor = Godot::Fun::Editor.new;
my $project = $editor.create_project("Raku Godot Fun");
$project.add(Godot::DirectionalLight.new);
$project.add(Godot::Camera.new);
$project.add(Godot::CSGCube.new)

my $scene = Godot::Fun::load_scene('hello.tscn');
$scene.run();
=end stash
