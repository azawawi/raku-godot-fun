
unit class Godot::Fun::Scene;

use Godot::Fun;

has $.name;
has Godot::Fun::Node $.root_node;
has @children;

method add(Str $name, Str $type, Real :$tx = 0.0, Real :$ty = 0.0, Real :$tz = 0.0) {
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
        my $name = $child.name;
        my $type = $child.type;
        my $tx = $child.tx;
        my $ty = $child.ty;
        my $tz = $child.tz;
        $text ~= qq{[node name="$name" type="$type" parent="."]\n};
        next if $tx == 0 && $ty == 0 && $tz == 0;
        $text ~= qq{transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, $tx, $ty, $tz )\n};
    }
    $text
}

method save(Str $folder) {
    my $project_path = $folder.IO.mkdir;
    my $file_path = $project_path.add($.name ~ '.tscn');
    $file_path.spurt(self.to-str);
    #say "Wrote '$file_path'";
}
