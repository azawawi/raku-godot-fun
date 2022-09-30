
unit class Godot::Fun::Scene;

use Godot::Fun;

has $.name;
has Godot::Fun::Node $.root_node;
has @children;
has Godot::Fun::Resource @.resources;

multi method add(Godot::Fun::Resource $resource) {
    @!resources.push($resource);
}

method render {
    my $text = qq{[gd_scene format=2]\n};
    my $node_name = $!root_node.name;
    my $node_type = $!root_node.type;
    for @!resources -> $resource {
        $text ~= $resource.render;
    }
    $text ~= qq{[node name="$node_name" type="$node_type"]\n};
    for $.root_node.children -> $child {
        $text ~= $child.render;
    }
    $text
}

method save(Str $folder) {
    my $project_path = $folder.IO.mkdir;
    my $file_path = $project_path.add($.name ~ '.tscn');
    $file_path.spurt(self.render);
}
