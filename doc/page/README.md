# Page and ViewModel

## Page
The `page` is created as a mixin to allow you to easily use it with Stateless and Stateful Widgets

<<< @/code/page/counter_page.dart

### Create Page

Running this command will generate a Page as well as an associated ViewModel.

```bash
flutter pub run flrx make:page MyPage
```

## ViewModel

A Flrx `Page` needs a `ViewModel`. A `ViewModel` provides the `AppState` to the `Page` in a form it can use it.

<<< @/code/page/viewmodels/counter_page_vm.dart
