
unit class Godot::Fun::Project;

use Godot::Fun::Scene;

has Str $.name;
has Godot::Fun::Scene $.scene;

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
