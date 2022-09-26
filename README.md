# Godot::Fun 

[![Actions
Status](https://github.com/azawawi/raku-godot-fun/workflows/test/badge.svg)](https://github.com/azawawi/raku-godot-fun/actions)

Experimental stuff.

Basically having fun with Godot and Raku :)

## References

- [SceneTree](https://docs.godotengine.org/en/stable/classes/class_scenetree.html)
- [Command line tutorial](https://docs.godotengine.org/en/stable/tutorials/editor/command_line_tutorial.html)

## Example

```Raku
use v6;
use Godot::Fun;

# Fun stuff to happen here...
```

For more examples, please see the [examples](examples) folder.

## Prerequisites

Please follow the instructions below based on your platform:

### Linux

Simply follow the download instructions in
[Godot Engine - Download | Linux](https://godotengine.org/download/linux)

### macOS

Simply follow the instructions in
[Godot Engine - Download | Mac OS](https://godotengine.org/download/osx)

### Windows

Simply follow the instructions in
[Godot Engine - Download | Windows](https://godotengine.org/download/windows)

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

