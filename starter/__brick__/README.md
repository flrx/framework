# {{name}}

A new Flutter project.

## Getting Started

This project is a starting point for a Flrx based Flutter application.
The app is setup using melos for scripts and multi package.

### Default scripts
You can run the following scripts as "melos <script name>" 

#### analyze

Run `flutter analyze` in all packages.
- Note: you can also rely on your IDEs Dart Analysis / Issues window.

#### gen

Runs all generate scripts

#### gen:build

Runs `flutter pub run build_runner build --delete-conflicting-outputs` build in all packages

#### gen:watch 

Build generated files from build_runner and watch them for changes
Runs `flutter pub run build_runner watch --delete-conflicting-outputs` build in all packages

#### gen:icons

Generate native Launcher Icons
You can customize the config from `app/config/icons.yaml`
See https://github.com/fluttercommunity/flutter_launcher_icons/blob/master/README.md#book-guide

#### gen:splash

Generate Native Splash Screen
You can customize the config from `app/config/splash.yaml`
See https://github.com/jonbhanson/flutter_native_splash/blob/master/README.md#usage

#### gen:assets

Generate an Asset class using spider
You can customize the config from `app/spider.yaml`
See https://birjuvachhani.github.io/spider/

#### env:print

Generate dart define strings from `app/.env` and prints them to console
See https://github.com/ibrahim-mubarak/define-env/blob/master/README.md#usage

#### env:copy

Generate dart define strings from `app/.env` and copies it to clipboard
See https://github.com/ibrahim-mubarak/define-env/blob/master/README.md#usage

##### test

Runs test in all packages with coverage