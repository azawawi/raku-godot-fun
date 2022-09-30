use v6;

unit class Godot::Fun;

=begin pod

=head1 Name

Godot::Fun - Raku Fun with Godot

=head1 Description

=end pod

role Godot::Fun::Resource {
    has Str $.path is required;
    has Str $.type;
    has Int $.id;

    method render() returns Str {
        my $path = self.path;
        my $type = self.type;
        my $id = self.id;
        my $text = qq{[ext_resource path="$path" type="$type" id=$id]\n};
        $text
    }
}

class Godot::Fun::TextureResource is Godot::Fun::Resource {
    has Str $.type = 'Texture';
}

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

    method render() returns Str {
        my $name = self.name;
        my $type = self.type;
        my $tx   = self.tx;
        my $ty   = self.ty;
        my $tz   = self.tz;
        my $text ~= qq{[node name="$name" type="$type" parent="."]\n};
        unless $tx == 0 && $ty == 0 && $tz == 0 {
            $text ~= qq{transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, $tx, $ty, $tz )\n};
        }
        $text
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
    has Bool $.shadow_enabled;

    method render() returns Str {
        my $text = self.Godot::Fun::Node::render;
        $text ~= qq{shadow_enabled = true\n} if $!shadow_enabled;
        $text
    }
}

class Godot::Fun::Camera is Godot::Fun::Node {
    has Str $.name = 'Camera';
    has Str $.type = 'Camera';
}

class Godot::Fun::Sprite3D is Godot::Fun::Node {
    has Str $.name = 'Sprite3D';
    has Str $.type = 'Sprite3D';
    has Godot::Fun::TextureResource $.texture;

    method render() returns Str {
        my $id = $!texture.id;
        my $text = self.Godot::Fun::Node::render;
        $text ~= qq{texture = ExtResource( $id )\n};
        $text
    }
}



