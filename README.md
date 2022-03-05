# flrx
**This is WIP. Please use cautiously.**

Mono repo for flrx. 
An opinionated library for using Redux with Flutter.

## Getting Started
You can setup the project using the `flrx:project` brick for mason

```shell
dart pub global activate mason_cli
mason add flrx:project -g --git-url https://github.com/flrx/framework
```

Then you can create a new flrx project anytime by running 

```shell
mason make flrx:project -o project_path
```

## Recommended Packages

| Package        | Version           |
| ------------- |:-------------:|
| flrx      | ![alt text][flrx] |
| flrx_validator      | ![alt text][flrx_validator] |
| flrx_test      | ![alt text][flrx_test] |

[flrx]: https://img.shields.io/pub/v/flrx_ "flrx"
[flrx_validator]: https://img.shields.io/pub/v/flrx_validator "flrx_validator"
[flrx_test]: https://img.shields.io/pub/v/flrx_test "flrx_test"

## Developing
`flrx` uses `melos` for it's monorepo setup
You'll need to first setup the example directory by running

```shell
melos setup_example
```

Then you can bootstrap the project 
```shell
melos bootstrap
```
