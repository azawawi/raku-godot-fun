use v6;

unit class Godot::Fun;

=begin pod

=head1 Name

Godot::Fun - Raku Fun with Godot

=head1 Description

=end pod

my $ext_id = 1;
my $sub_id = 1;

role Godot::Fun::Resource {
    has Str $.type;
}

role Godot::Fun::ExtResource does Godot::Fun::Resource {
    has Str $.path is required;
    has Int $.id;

    # TODO remove ugly workaround
    method TWEAK {
        $!id = $ext_id++;
    }

    method render() returns Str {
        my $path = self.path;
        my $type = self.type;
        my $id = self.id;
        my $text = qq{[ext_resource path="$path" type="$type" id=$id]\n\n};
        $text
    }
}

role Godot::Fun::SubResource does Godot::Fun::Resource {
    has Int $.id;

    # TODO remove ugly workaround
    method TWEAK {
        $!id = $sub_id++;
    }

    method render() returns Str {
        my $type = self.type;
        my $id = self.id;
        my $text = qq{[sub_resource type="$type" id=$id]\n};
        $text
    }
}

class Godot::Fun::TextureResource is Godot::Fun::ExtResource {
    has Str $.type = 'Texture';
}

class Godot::Fun::Color {
    has Real $.red = 0.0;
    has Real $.green = 0.0;
    has Real $.blue = 0.0;
    has Real $.alpha = 1.0;
}

class Godot::Fun::SpatialMaterial is Godot::Fun::SubResource {
    has Str $.type = 'SpatialMaterial';
    has Godot::Fun::Color $.albedo_color;

    method render() returns Str {
        my $type = self.type;
        my $id = self.id;
        my $r = $.albedo_color.red;
        my $g = $.albedo_color.green;
        my $b = $.albedo_color.blue;
        my $a = $.albedo_color.alpha;
        my $text = self.Godot::Fun::SubResource::render;
        $text ~= qq{albedo_color = Color( $r, $g, $b, $a )\n\n};
        $text
    }
}

#TODO handle ShaderMaterial in the future
role Godot::Fun::HasAMaterial {
    has Godot::Fun::SpatialMaterial $.material;
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

    method TWEAK {
        # Trim name
        $!name = $!name.trim;

        die "Empty node name is not allowed"
            if $!name eq '';

        #
        # Validate node name
        # node name should not contain the following chars:
        # .  :  @  /  "  %
        #
        my @bad_chars = '.', ':', '@', '/', '"', '%';
        for @bad_chars -> $bad_char {
            if $!name.contains($bad_char) {
                # Invalid node name
                die q{Node name should not contains the following characters:\n} ~ @bad_chars.join(' ');
            }
        }
    }

    method add(Godot::Fun::Node $child) {
        @.children.push($child);
    }

    method render() returns Str {
        my $name = self.name;
        my $type = self.type;
        my $tx   = self.tx;
        my $ty   = self.ty;
        my $tz   = self.tz;
        my $text = qq{[node name="$name" type="$type" parent="."]\n};
        unless $tx == 0 && $ty == 0 && $tz == 0 {
            $text ~= qq{transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, $tx, $ty, $tz )\n};
        }
        if self.does(Godot::Fun::HasAMaterial) && self.material {
            my $material_id = self.material.id;
            $text ~= qq{material = SubResource( $material_id )\n};
        }
        $text ~= "\n";
        $text
    }
}


class Godot::Fun::Spatial is Godot::Fun::Node {
    has Str $.name = 'Spatial';
    has Str $.type = 'Spatial';
}

class Godot::Fun::CSGBox is Godot::Fun::Node does Godot::Fun::HasAMaterial {
    has Str $.name = 'CSGBox';
    has Str $.type = 'CSGBox';
    has Real $.width = 2;
    has Real $.height = 2;
    has Real $.depth = 2;

    method render() returns Str {
        my $text = self.Godot::Fun::Node::render;
        $text ~= qq{width = $!width\n}
            if $!width != 2;
        $text ~= qq{height = $!height\n}
            if $!height != 2;
        $text ~= qq{depth = $!depth\n}
            if $!depth != 2;
        $text
    }
}

class Godot::Fun::CSGCylinder is Godot::Fun::Node does Godot::Fun::HasAMaterial {
    has Str $.name = 'CSGCylinder';
    has Str $.type = 'CSGCylinder';
    has Real $.radius = 1;
    has Real $.height = 1;
    has Int $.sides = 8;
    has Bool $.cone;

    method render() returns Str {
        my $text = self.Godot::Fun::Node::render;
        $text ~= qq{radius = $!radius\n}
            if $!radius != 1;
        $text ~= qq{height = $!height\n}
            if $!height != 1;
        $text ~= qq{sides = $!sides\n}
            if $!sides != 8;
        $text ~= qq{cone = true\n}
            if $!cone;
        $text
    }
}

class Godot::Fun::CSGMesh is Godot::Fun::Node {
    has Str $.name = 'CSGMesh';
    has Str $.type = 'CSGMesh';
}

class Godot::Fun::CSGPolygon is Godot::Fun::Node does Godot::Fun::HasAMaterial {
    has Str $.name = 'CSGPolygon';
    has Str $.type = 'CSGPolygon';
}

class Godot::Fun::CSGSphere is Godot::Fun::Node does Godot::Fun::HasAMaterial {
    has Str $.name = 'CSGSphere';
    has Str $.type = 'CSGSphere';
}

class Godot::Fun::CSGTorus is Godot::Fun::Node does Godot::Fun::HasAMaterial {
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



