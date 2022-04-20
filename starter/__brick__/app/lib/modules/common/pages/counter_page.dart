import 'package:flrx/flrx.dart';
import 'package:{{name}}/modules/common/pages/viewmodels/counter_page_vm.dart';
import 'package:{{name}}/store/states/app_state.dart';
import 'package:flutter/material.dart' hide Page;

class CounterPage extends StatelessWidget with Page<AppState, CounterPageVM> {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget buildContent(BuildContext context, CounterPageVM viewModel) {
    {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Home Page'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                viewModel.counter.toString(),
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: viewModel.incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
    }
  }

  @override
  initViewModel() => CounterPageVM();
}
