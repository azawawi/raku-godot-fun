
unit class Godot::Fun::Scene;

use Godot::Fun;

has $.name;
has Godot::Fun::Node $.root_node;
has Godot::Fun::Resource @.resources;

multi method add(Godot::Fun::Resource $resource) {
    @!resources.push($resource);
}

method render {
    # Add ext and sub resources automatically
    for $.root_node.children -> $child {
        if $child.can('material') {
            self.add($child.material);
        } elsif $child.can('texture') {
            self.add($child.texture);
        } elsif $child.can('mesh') {
            self.add($child.mesh);
        }
    }

    # Add load steps for a proper loading bars
    my $text = '';
    my $num_resources = @!resources.elems + 1;
    if $num_resources > 1 {
        $text = qq{[gd_scene load_steps=$num_resources format=2]\n};
    } else {
       $text = qq{[gd_scene format=2]\n};
    }

    # Render resources
    for @!resources -> $resource {
        $text ~= $resource.render;
    }
    # Render root node
    my $node_name = $!root_node.name;
    my $node_type = $!root_node.type;
    $text ~= qq{[node name="$node_name" type="$node_type"]\n};

    # Render children
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
