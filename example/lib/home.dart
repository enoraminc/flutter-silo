import 'package:example/util/silo_type_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:silo/dispatcher/silo_dispatcher_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silo/model/silo_dispatcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'silo_implementation/example_use_case/example_use_case_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final phCtrl = TextEditingController();

  String poolSelected = ExampleUseCaseModel.poolList.first;

  void onSubmit() {
    ExampleUseCaseModel data = ExampleUseCaseModel(
      id: DateTime.now().millisecondsSinceEpoch,
      ph: int.tryParse(phCtrl.text) ?? -1,
      pool: poolSelected,
    );

    context.read<SiloDispatcherBloc>().add(
          DispatchSiloEvent(
            dispatcher: SiloDispatcherModel(
              data: data.toMap(),
              type: SiloTypeUtil.exampleUseCaseType,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Silo Example"),
      ),
      body: BlocListener<SiloDispatcherBloc, SiloDispatcherState>(
        listener: (context, state) {
          if (state is DispatchSiloSuccess) {
            phCtrl.clear();
            showSnackBar(state.message);
          }

          if (state is DispatchSiloFailed) {
            showSnackBar(state.message, isError: true);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "No. Kolam",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              poolSelectorWidget(),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "PH",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              phTexFieldWidget(context),
              const SizedBox(
                height: 10,
              ),
              buttonWidget(),
            ],
          ),
        ),
      ),
      floatingActionButton: floatingButtonWidget(),
    );
  }

  Wrap poolSelectorWidget() {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      runSpacing: 5,
      spacing: 5,
      children: ExampleUseCaseModel.poolList
          .map(
            (pool) => InkWell(
              onTap: () {
                setState(() {
                  poolSelected = pool;
                });
              },
              child: Chip(
                label: Text(pool),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                backgroundColor: poolSelected == pool
                    ? Colors.blue
                    : Colors.grey.withOpacity(.5),
              ),
            ),
          )
          .toList(),
    );
  }

  TextField phTexFieldWidget(BuildContext context) {
    return TextField(
      controller: phCtrl,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: "Masukkan PH (0-14)",
        hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
        // suffixIcon: suffix,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
    );
  }

  FloatingActionButton floatingButtonWidget() {
    return FloatingActionButton(
      child: const Icon(
        Icons.book,
        color: Colors.white,
      ),
      onPressed: () {
        launchUrlString(
            "https://testnet.hederaexplorer.io/search-details/topic/${ExampleUseCaseModel.topicId}");
      },
    );
  }

  Builder buttonWidget() {
    return Builder(builder: (context) {
      final isLoading = context.select(
          (SiloDispatcherBloc element) => element.state is DispatchSiloLoading);

      return SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: !isLoading ? onSubmit : null,
          child: isLoading
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
        ),
      );
    });
  }

  /// Show snackbar with this function
  void showSnackBar(
    String message, {
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: isError ? Colors.red : Colors.blue,
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}
