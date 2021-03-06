# Changelog

All notable changes to
[the `graphqelm` npm package](https://www.npmjs.com/package/graphqelm)
will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [3.1.4] - 2018-02-07

### Added

* Generate type alias for required args to make it easier to annotate
  consumer code. Fixes #31.

## [3.1.3] - 2018-02-07

### Fixed

* Add support for non-string scalars, fixes issue #37.

## [3.1.2] - 2018-02-06

### Changed

* Use `Decode.nullable` rather than `Decode.maybe` so that decode failures don't
  incorrectly get swallowed into a `Nothing` values but rather bubble up as
  `Err` `Results`.

### Added

* Generate type alias for optional args to make it easier to annotate consumer code.

## [3.1.1] - 2018-02-04

### Added

* Include type alias for records in the union type for Input Objects with loops.
  This allows for nicer annotations in consumer code.

## [3.1.0] - 2018-02-04

### Changed

* Generate wrapped record union type for Input Objects with loop (recursive or circular references),
  and plain type alias for Input Objects with no loop.

## [3.0.1] - 2018-02-01

### Fixed

* Fix issue with type generation for InputObject type aliases that contain a List type.

## [3.0.0] - 2018-02-01

### Fixed

* Generate InputObjects as types (not type aliases) inside a single file to allow for recursive or circular input types.

## [2.1.3] - 2018-01-28

### Added

* Add log statements to show progress while running CLI.

### Changed

* Include deprecated fields by default. Add `--excludeDeprecated` CLI flag in place
  of `--includeDeprecated`.

## [2.1.2] - 2018-01-20

### Changed

* Generate special module for Subscriptions.

## [2.1.1] - 2018-01-17

### Changed

* Renamed type variables from `selection` to `decodesTo` for clarity.
* Updated code generation to use type and module name `Field` rather than `FieldDecoder` for elm package version 7.0.0.

## [2.1.0] - 2018-01-13

### Fixed

* Single-letter names no longer cause exceptions (like `x` or `y`).

### Changed

* Update name normalization strategy to make only the minimal change to make a name valid
  (that is, put leading underscores at the tail, and make sure the first letter is the correct case).
  Unless it is ALL_UPPERCASE_UNDERSCORE_SEPARATED_NAME, then make it ClassCase.

## [2.0.3] - 2018-01-13

### Added

* Generate metadata json file with target elm package version and npm package version.

### Removed

* Remove npm version number and target elm package version number from comments
  on generated modules to reduce diff noise in future updates.

## [2.0.2] - 2018-01-11

### Fixed

* Fixed error on windows related to shelling out.

### Removed

* Stopped generating unnecessary InputObject type definitions file.

## [2.0.1] - 2018-01-10

### Added

* Add `--output` flag to command line to choose a directory
  other than `./src` for generated output
* Support intropsection json files with no top-level `data` json key.

## [2.0.0] - 2018-01-10

### Added

* Generate Scalars module with type definitions/constructors for each custom scalar.
* Experimental `--introspection-file` flag to allow users to pass in a file with
  the result of the introspection query. This may change in the future.

## [1.0.1] - 2018-01-08

### Added

* Generate InputObject modules for type-safe input objects.
