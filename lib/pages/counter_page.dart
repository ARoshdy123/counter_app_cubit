import 'package:counter_app_cubit/bloc/counter_cubit.dart';
import 'package:counter_app_cubit/bloc/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counterCubit = context.read<CounterCubit>();
    final themeCubit = context.read<ThemeCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Counter'),
        ),
        actions: [
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return IconButton(
                onPressed: () => themeCubit.changeTheme(),
                icon: Icon(themeState.themeData.brightness == Brightness.dark
                    ? Icons.light_mode
                    : Icons.dark_mode),
              );
            },
          )
        ],
      ),
      body: Center(
        child: BlocConsumer<CounterCubit, int>(
          listener: (context, count) {
            // Check counter when reaches 10 or -10 and show a snack bar message.
            if (count == 10 || count == -10) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Counter reached $count'),

                ),
              );
            }
          },
          builder: (context, count) {
            return Text('$count',
                style: Theme.of(context).textTheme.headlineLarge);
          },
        ),
      ),
      floatingActionButton: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () => counterCubit.increment(),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          SizedBox(width: 12),
          FloatingActionButton(
            onPressed: () => counterCubit.decrement(),
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
