
unit class Godot::Fun::Scene;

use Godot::Fun;

has $.name;
has Godot::Fun::Node $.root_node;
has @children;

# Deprecated. Please use .add on Node object
method add(Str $name, Str $type, Real :$tx = 0.0, Real :$ty = 0.0, Real :$tz = 0.0) is DEPRECATED {
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
    my %node = name => $name, type => $type, tx => $tx, ty => $ty, tz => $tz;
    @children.push(%node);
}

method to-str {
    my $text = qq{[gd_scene format=2]\n};
    my $node_name = $!root_node.name;
    my $node_type = $!root_node.type;
    $text ~= qq{[node name="$node_name" type="$node_type"]\n};
    for $.root_node.children -> $child {
        $text ~= $child.render;
    }
    $text
}

method save(Str $folder) {
    my $project_path = $folder.IO.mkdir;
    my $file_path = $project_path.add($.name ~ '.tscn');
    $file_path.spurt(self.to-str);
}
