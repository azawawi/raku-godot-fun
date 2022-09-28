
unit class Godot::Fun::Scene;

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

method save {
    my $filename = $!name ~ '.tscn';
    $filename.IO.spurt(self.to-str);
    say "Wrote '$filename'";
}