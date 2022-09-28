#!/usr/bin/env raku

use v6;

class Scene {
    has Str $.name;
    has Str $.type;
    has @children;

    method add(Str $name, Str $type) {
        # Validate node name
        # node name should not contain the following chars:
        # . : @ / " %
        my @bad_chars = '.', ':', '@', '/', '"', '%';
        for @bad_chars -> $bad_char {
            if $name.contains($bad_char) {
                # Invalid node name
                die q{Invalid node name since it contains } ~ @bad_chars.join(' ');
            }
        }
        my %node = name => $name, type => $type;
        @children.push(%node);
    }

    method to-str {
        my $text = qq{[gd_scene format=2]\n};
        $text ~= qq{[node name="$!name" type="$!type"]\n};
        for @children -> $child {
            $text ~= qq{[node name="$child<name>" type="$child<type>" parent="."]\n}
        }
        $text
    }
}

class Project {
    has Str $.name;
    has Scene $.scene;

    method to-str {
        my $main_scene_name = "res://" ~ $!scene.name ~ ".tscn";
    my $project = qq{
        ; Engine configuration file.
        ; It's best edited using the editor UI and not directly,
        ; since the parameters that go here are not all obvious.
        ;
        ; Format:
        ;   [section] ; section goes between []
        ;   param=value ; assign values to parameters

        config_version=4

        [application]

        config/name="$!name"
        run/main_scene="$main_scene_name"
        config/icon="res://icon.png"

        [gui]

        common/drop_mouse_on_gui_input_disabled=true

        [physics]

        common/enable_pause_aware_picking=true

        [rendering]

        environment/default_environment="res://default_env.tres"
    };
    }
    
}

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

my $scene = Scene.new(name => 'Hello', type => 'Spatial');
$scene.add('Cube0' ~ $_, 'CSGBox') for 1..5;

my $project = Project.new(name => 'Hello', scene => $scene);

$filename = 'project.godot';
$filename.IO.spurt($project.to-str);
say "Wrote '$filename'";
$filename = "Hello.tscn";
$filename.IO.spurt($scene.to-str);
say "Wrote '$filename'";
