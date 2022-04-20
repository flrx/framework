## [v0.0.11]
### Changed
- ErrorManager now accepts an AsyncCallback instead of VoidCallback

## [v0.0.10]
### Changed
- `CatcherConfig` now returns asynchronously
- Updated flutter_redux version

## [V0.0.9]
### Added
- `flrx_test` Library for testing flrx applications


## [V0.0.8]
### Added
- Add `gen` command for `flutter_native_splash`, `flutter_launcher_icons`, `define_env`
- Add method to check if module exists with a specific name
- Add application config, Change error reporter
- Add new Logger

### Changed
- Setup Error management, then init app
- Add const optimizations

### Removed
- Remove Localizer

## [V0.0.7]
### Changed
- Update Dependencies 
- Clean code based on pedantic rules
- Update to nullsafety

### Removed  
- Remove Deprecated features
- Remove flrx_validator
- Make Service Locator a singleton, Ensure better concurrency for Module registration

## [v0.0.6]
### Added
- Added `Module`s in place of Retrievers. Modules can be used to setup routes, and register implementations of abstract classes.

### Changed
- Updated Dependencies

### Removed
- ApiClient and Dio dependency.
- setupSingleton in Application init in favor of modules

## [v0.0.5]
### Added
- Redux Logging Middleware
- Description in EmptyView

### Changed
- Cleaned up Store Retriever. It should now be implemented in your project.
- Updated Dependencies

### Removed
- Removed Redux Persist. It can be added back to your project if you are using it.

## [v0.0.4]
### Removed
- Moved validator to it's own package. See [Flrx Validator](https://pub.dev/packages/flrx_validator)

## [v0.0.3]
### Added
- Add `RegexRule`
- Add `EmptyView` Widget

### Changed
- Allow Rules to give custom validation message

### Fixed
- Fix Tests for validation messages

### Deprecated
- `AppRouter.generateParamRoutes` in favor of `StringUtils.replaceWithValues`

## [v0.0.2+2]
### Fixed
- Fix `MinLength` and `MaxLength` validation message

## [v0.0.2+1]
### Fixed
- Deleted old `Validator`

## [v0.0.2]
### Added
- Added `Rule` Class, refactored `Validator` (Breaking change).
- Added `EmailRule`, `MinLengthRule` and `RequiredRule`, `MaxLengthRule`, `AnyRule`, `OneOfRule`.
- Added `make:rule` command.

### Changed
- Improved Documentation.

### Deprecated
- Deprecate `ApiClient#setDefaultHeaders`.

[v0.0.6]: https://github.com/flrx/framework/compare/v0.0.5...v0.0.6
[v0.0.5]: https://github.com/flrx/framework/compare/v0.0.4...v0.0.5
[v0.0.4]: https://github.com/flrx/framework/compare/v0.0.3...v0.0.4
[v0.0.3]: https://github.com/flrx/framework/compare/v0.0.2+2...v0.0.3
[v0.0.2+2]: https://github.com/flrx/framework/compare/v0.0.2+1...v0.0.2+2
[v0.0.2+1]: https://github.com/flrx/framework/compare/v0.0.2...v0.0.2+1
[v0.0.2]: https://github.com/flrx/framework/tag/v0.0.2

