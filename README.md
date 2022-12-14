# Godot::Fun

[![Actions
Status](https://github.com/azawawi/raku-godot-fun/workflows/test/badge.svg)](https://github.com/azawawi/raku-godot-fun/actions)

**Warning:** This is totally experimental and is not to meant to used in any production work at
the moment.

Basically having fun with Godot 3 Game Engine and Raku :)

The idea here is to do the following:
- Create a Godot3 project structure with Camelia as a default icon.
- Add 3D scene with some defaults (e.g. directional light, camera, materials).
- Run godot project on the final project

![Raku example
1](https://raw.githubusercontent.com/azawawi/raku-godot-fun/main/screenshots/example01.png)

## Example

```Raku
use v6;

use Godot::Fun;
use Godot::Fun::Project;
use Godot::Fun::Scene;

my $project_folder = 'hello-project';

# Create 3D scene with CSG primitives, directional light and camera

my $spatial = Godot::Fun::Spatial.new;
$spatial.add: Godot::Fun::CSGBox.new(name => 'Floor', ty => -1.0, material => material(grey),
    width => 20, height => 0.25, depth => 20);
$spatial.add: Godot::Fun::CSGBox.new(material => material(red));
$spatial.add: Godot::Fun::CSGCylinder.new(tx =>  5, material => material(green));
$spatial.add: Godot::Fun::CSGSphere.new(tx => -5, material => material(blue));
$spatial.add: Godot::Fun::CSGSphere.new(name => 'Small Sphere', tx => -5, ty => 2,
    radius => 0.5, material => material(dark_green));
$spatial.add: Godot::Fun::CSGTorus.new(tz => -5, material => material(yellow));
$spatial.add: Godot::Fun::CSGTorus.new(name => 'Smaller Torus', tz => -5, ty => 3,
    material => material(yellow), inner_radius => 1, outer_radius => 2);
$spatial.add: Godot::Fun::CSGPolygon.new(tz =>  5, material => material(pink));
$spatial.add: Godot::Fun::CSGMesh.new;
$spatial.add: Godot::Fun::CSGCylinder.new(name => 'Cone', tx => 8, height => 2, cone => True,
    material => material(orange));
$spatial.add: Godot::Fun::CSGCombiner.new;
$spatial.add: Godot::Fun::DirectionalLight.new(shadow_enabled => True);
$spatial.add: Godot::Fun::Camera.new(tx => 2, ty => 4, tz => 11);

my $texture = Godot::Fun::TextureResource.new(
    name => "camelia.png",
    path => "res://assets/camelia.png",
);
$spatial.add: Godot::Fun::Sprite3D.new(texture => $texture, ty => 3);

my $scene = Godot::Fun::Scene.new: name => 'Hello', root_node => $spatial;
$scene.save: $project_folder;

# Create Godot project
my $project = Godot::Fun::Project.new: name => 'Hello From Raku!', scene => $scene;
$project.save: $project_folder;

# Open project in Godot
$project.open: $project_folder;

# Run a project in Godot
# $project.run: $project_folder;
```

For more examples, please see the [examples](examples) folder.

## Prerequisites

Please follow the instructions to install Godot engine based on your platform:

- [Godot on Linux](https://godotengine.org/download/linux)
- [Godot on macOS](https://godotengine.org/download/osx)
- [Godot on Windows](https://godotengine.org/download/windows)

Please make sure that `godot` is accessible from your `PATH` variable.

## Installation

- Install this module using [zef](https://github.com/ugexe/zef):

```
$ zef install Godot::Fun
```

## Testing

- To run tests:
```
$ prove --ext .rakutest -ve "raku -I."
```

- To run all tests including author tests (Please make sure
[Test::Meta](https://github.com/jonathanstowe/Test-META) is installed):
```
$ zef install Test::META
$ AUTHOR_TESTING=1 prove --ext .rakutest -ve "raku -I."

# On windows
$ $env:AUTHOR_TESTING=1; prove --ext .rakutest -ve "raku -I."

```

## Compatibility

Currently I am testing using Godot 3.5.1

## References

- [TSCN file format](https://docs.godotengine.org/en/stable/development/file_formats/tscn.htm://docs.godotengine.org/en/stable/development/file_formats/tscn.html)
- [Command line tutorial](https://docs.godotengine.org/en/stable/tutorials/editor/command_line_tutorial.html)

## Author

Ahmad M. Zawawi, azawawi on #raku, https://github.com/azawawi/

## License

MIT License
