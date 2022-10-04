
# Changelog

## Not released
- Add exported subs `color` and `material`.
- Materials and colors are now stored in a lookup table.
- Simplify example.
- Add `CSGShape` role and now CSG operation is rendered correctly.
- Add `inner_radius`, `outer_radius`, `ring_sides`, `sides`, `smooth_faces` to `CSGTorus`.
- Show camelia in the boot splash screen.
- Added trailing whitespace tests.
- Copy assets folder from distribution resources to project folder.

## 0.5.0 - Sat 2022-10-01
- Add `width`, `height` and `depth` to `CSGBox`.
- Add a grey CSG Box floor in the example.
- Add radius, height, sides and `cone` flag to `CSGCylinder`.
- Add an orange cone in the example.
- Add `radius`, `radial_segments`, `rings` and `smooth_faces` to `CSGSphere`.
- Add `smooth_faces` to `CSGCylinder`.
- Add `open` and `run` to `Project`.
- Add ext and sub resources automatically.
- Add load steps for a proper loading bars.

## 0.4.0 - Fri 2022-09-30
- Add node name validation.
- Remove deprecated Scene.add method.
- Move assets copy logic to ::Project.
- Add colored materials.
- Add external and sub resources automatic counter.
- Add whitespace between nodes, resources in rendered text.

## 0.3.0 - Fri 2022-09-30
- Add CSGCombiner
- Beautify the examples. Less parenthesis.
- Only one screenshot is needed.
- Deprecated Scene.add.
- Move rendering logic to child node.
- Add tests
- Breaking change: Move Godot::Fun::Resource to Godot::Fun
- Add ::Sprite3D and ::TextureResource
- Update example to show Camelia sprite3d :)
- Add `shadow_enabled` to Godot::Fun::DirectionalLight.

## 0.2.2 - Fri 2022-09-30
- Add a proper Changelog.
- Less code.
- Update TODO.
- Removed old TODO example.
- Make screenshots smaller.

## 0.2.1 - Thu 2022-09-29
- Add example screenshots to README

## 0.2.0 - Thu 2022-09-29
- Update project test.
- Update example to have extra OO sugar fun.
- Scene now has a root node.
- Update example in README.
- Changed to Real in tx, ty and tz (aka translation).
- Added directional light and camera.
- Simplify docs.
- Added author testing instructions on windows in README.
- Added tests for ::Project.
- Added compatibility docs to README.
- Less debug info.
- Added more CSG primitives and basic translation.

## 0.1.0 - Wed 2022-09-28

- Move example file to examples.
- Remove unneeded gdscript and doc refs.
- Simplify examples.
- Add open project in godot.
- Update README example.
- Add project folder creation.
- Update README with goals.
- Refactor and move save functionality to each class. Add resource class.
- Ignore godot files
- Add godot project and scene classes.
- Refactor example.
- Add load tests.
- Add draft godot project generation.
- Add sample example idea.
- Simplify prerequisites section in README.
- Add references section and a sample command line hello gdscript.

## 0.0.1 - Mon 2022-09-26

- Added Github test workflow.
- Added Initial project structure.

