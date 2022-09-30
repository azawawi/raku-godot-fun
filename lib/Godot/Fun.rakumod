use v6;

unit class Godot::Fun;

=begin pod

=head1 Name

Godot::Fun - Raku Fun with Godot

=head1 Description

=end pod


role Godot::Fun::Node {
    has Str $.name = 'Node';
    has Str $.type = 'Node';
    has Real $.tx = 0.0;
    has Real $.ty = 0.0;
    has Real $.tz = 0.0;
    has Real $.rx = 0.0;
    has Real $.ry = 0.0;
    has Real $.rz = 0.0;
    has Godot::Fun::Node @.children;

    # TODO validate name if set again

    method add(Godot::Fun::Node $child) {
        @.children.push($child);
    }
}

class Godot::Fun::Spatial is Godot::Fun::Node {
    has Str $.name = 'Spatial';
    has Str $.type = 'Spatial';
}

class Godot::Fun::CSGBox is Godot::Fun::Node {
    has Str $.name = 'CSGBox';
    has Str $.type = 'CSGBox';
}

class Godot::Fun::CSGCylinder is Godot::Fun::Node {
    has Str $.name = 'CSGCylinder';
    has Str $.type = 'CSGCylinder';
}

class Godot::Fun::CSGMesh is Godot::Fun::Node {
    has Str $.name = 'CSGMesh';
    has Str $.type = 'CSGMesh';
}

class Godot::Fun::CSGPolygon is Godot::Fun::Node {
    has Str $.name = 'CSGPolygon';
    has Str $.type = 'CSGPolygon';
}

class Godot::Fun::CSGSphere is Godot::Fun::Node {
    has Str $.name = 'CSGSphere';
    has Str $.type = 'CSGSphere';
}

class Godot::Fun::CSGTorus is Godot::Fun::Node {
    has Str $.name = 'CSGTorus';
    has Str $.type = 'CSGTorus';
}

class Godot::Fun::CSGCombiner is Godot::Fun::Node {
    has Str $.name = 'CSGCombiner';
    has Str $.type = 'CSGCombiner';
}

class Godot::Fun::DirectionalLight is Godot::Fun::Node {
    has Str $.name= 'DirectionalLight';
    has Str $.type = 'DirectionalLight';
}

class Godot::Fun::Camera is Godot::Fun::Node {
    has Str $.name = 'Camera';
    has Str $.type = 'Camera';
}
