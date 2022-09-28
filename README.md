# Godot::Fun 

[![Actions
Status](https://github.com/azawawi/raku-godot-fun/workflows/test/badge.svg)](https://github.com/azawawi/raku-godot-fun/actions)

**Warning:** This is totally experimental and is not to meant to used in any production work at
the moment.

Basically having fun with Godot and Raku :)

The idea here is to do the following:
- Create a Godot3 project structure with Camelia as a default icon.
- Add 3D scene with some defaults (e.g. directional light, camera, materials).
- Run godot project on the final project

## References

- [Command line tutorial](https://docs.godotengine.org/en/stable/tutorials/editor/command_line_tutorial.html)

## Example

```Raku
use v6;

use Godot::Fun::Project;
use Godot::Fun::Scene;

my $project_folder = 'hello-project';

# Create 3D scene with CSG primitives
my $scene = Godot::Fun::Scene.new(name => 'Hello', type => 'Spatial');
$scene.add('Box', 'CSGBox');
$scene.add('Cylinder', 'CSGCylinder', :tx(5));
$scene.add('Sphere', 'CSGSphere', :tx(-5));
$scene.add('Polygon', 'CSGPolygon', :tz(5));
$scene.add('Mesh', 'CSGMesh');
$scene.add('Torus', 'CSGTorus', :tz(-5));
$scene.save($project_folder);

# Create Godot project
my $project = Godot::Fun::Project.new(name => 'Hello', scene => $scene);
$project.save($project_folder);

# Open project in Godot
run 'godot', $project_folder.IO.add('project.godot');
```

For more examples, please see the [examples](examples) folder.

## Prerequisites

Please follow the instructions below based on your platform:

|Platform|URL|
|-|-|
|Linux|[Godot Engine - Download \| Linux](https://godotengine.org/download/linux)|
|macOS|[Godot Engine - Download \| Mac OS](https://godotengine.org/download/osx)|
|Windows|[Godot Engine - Download \| Windows](https://godotengine.org/download/windows)|

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
```

## Author

Ahmad M. Zawawi, azawawi on #raku, https://github.com/azawawi/

## License

MIT License

