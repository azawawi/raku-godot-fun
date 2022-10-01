
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
    config/icon="res://assets/camelia.png"

    [gui]

    common/drop_mouse_on_gui_input_disabled=true

    [physics]

    common/enable_pause_aware_picking=true

    [rendering]

    environment/default_environment="res://default_env.tres"
    };
}

method save(Str $folder) {
    my $project_path = $folder.IO.mkdir;

    # Write Default environment resource file
    my $file_path = $project_path.add('default_env.tres');
    my $default_env = qq{
    [gd_resource type="Environment" load_steps=2 format=2]

    [sub_resource type="ProceduralSky" id=1]

    [resource]
    background_mode = 2
    background_sky = SubResource( 1 )
    };
    $file_path.spurt($default_env);

    # Write project file
    $file_path = $project_path.add: 'project.godot';
    $file_path.spurt(self.to-str);

    # Make assets folder, copy assets to their proper paths
    my $assets_folder = $project_path.add('assets');
    $assets_folder.mkdir;
    my $image = %?RESOURCES<assets/camelia.png>;
    $image.copy($assets_folder.add('camelia.png'));
}

method open($folder) {
    run 'godot', $folder.IO.add: 'project.godot';
}

method run($folder) {
    run 'godot', :cwd($folder);
}
