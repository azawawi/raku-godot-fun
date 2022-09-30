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

![Raku example
2](https://raw.githubusercontent.com/azawawi/raku-godot-fun/main/screenshots/example02.png)

## Example

```Raku
use v6;

use Godot::Fun;
use Godot::Fun::Project;
use Godot::Fun::Scene;

my $project_folder = 'hello-project';

# Create 3D scene with CSG primitives, directional light and camera
my $spatial = Godot::Fun::Spatial.new;
$spatial.add: Godot::Fun::CSGBox.new;
$spatial.add: Godot::Fun::CSGCylinder.new(tx =>  5);
$spatial.add: Godot::Fun::CSGSphere.new(tx => -5);
$spatial.add: Godot::Fun::CSGPolygon.new(tz =>  5);
$spatial.add: Godot::Fun::CSGMesh.new;
$spatial.add: Godot::Fun::CSGTorus.new(tz => -5);
$spatial.add: Godot::Fun::CSGCombiner.new;
$spatial.add: Godot::Fun::DirectionalLight.new;
$spatial.add: Godot::Fun::Camera.new(ty => 3.5, tz => 10.5);

my $scene = Godot::Fun::Scene.new: name => 'Hello', root_node => $spatial;
$scene.save: $project_folder;

# Create Godot project
my $project = Godot::Fun::Project.new: name => 'Hello From Raku!', scene => $scene;
$project.save: $project_folder;

# Open project in Godot
run 'godot', $project_folder.IO.add: 'project.godot';
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

- [Command line tutorial](https://docs.godotengine.org/en/stable/tutorials/editor/command_line_tutorial.html)

## Author

Ahmad M. Zawawi, azawawi on #raku, https://github.com/azawawi/

## License

MIT License

