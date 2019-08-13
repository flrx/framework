## [v0.0.4]
### Changed
- **BREAKING**: Moved validator to it's own package. See [Flrx Validator](https://pub.dev/packages/flrx_validator)

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

[v0.0.4]: https://github.com/flrx/framework/compare/v0.0.3...v0.0.4
[v0.0.3]: https://github.com/flrx/framework/compare/v0.0.2+2...v0.0.3
[v0.0.2+2]: https://github.com/flrx/framework/compare/v0.0.2+1...v0.0.2+2
[v0.0.2+1]: https://github.com/flrx/framework/compare/v0.0.2...v0.0.2+1
[v0.0.2]: https://github.com/flrx/framework/tag/v0.0.2

