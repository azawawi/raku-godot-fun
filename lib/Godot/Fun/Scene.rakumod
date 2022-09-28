
unit class Godot::Fun::Scene;

has Str $.name;
has Str $.type;
has @children;

method add(Str $name, Str $type, Int :$tx = 0, Int :$ty = 0, Int :$tz = 0) {
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
    $text ~= qq{[node name="$!name" type="$!type"]\n};
    for @children -> $child {
        $text ~= qq{[node name="$child<name>" type="$child<type>" parent="."]\n};
        say $child;
        next if $child<tx> == 0 && $child<ty> == 0 && $child<tz> == 0;
        $text ~= qq{transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, $child<tx>, $child<ty>, $child<tz> )\n};
    }
    $text
}

method save(Str $folder) {
    my $project_path = $folder.IO.mkdir;
    my $file_path = $project_path.add($!name ~ '.tscn');
    $file_path.spurt(self.to-str);
    say "Wrote '$file_path'";
}
