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

