import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/age_estimation_cubit.dart';

class NameInput extends StatefulWidget {
  const NameInput({super.key});

  @override
  State<NameInput> createState() => _NameInputState();
}

class _NameInputState extends State<NameInput> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: _shadow,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _nameController,
                style: Theme.of(context).textTheme.titleLarge,
                textCapitalization: TextCapitalization.words,
                onSubmitted: (_) {
                  _onKeyboardSubmitPressed(context);
                },
                decoration: const InputDecoration.collapsed(
                  hintText: 'First or full name',
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: _shadow,
          ),
          child: BlocBuilder<AgeEstimationCubit, AgeEstimationState>(
            builder: (context, state) {
              return IconButton.filled(
                iconSize: 30,
                icon: const Icon(Icons.search),
                onPressed: state is AgeEstimationLoading
                    ? null
                    : () {
                        _onSubmitButtonPressed(context);
                      },
              );
            },
          ),
        ),
      ],
    );
  }

  void _onKeyboardSubmitPressed(BuildContext context) {
    if (_nameController.text.isNotEmpty) {
      context.read<AgeEstimationCubit>().onNameSubmitted(_nameController.text);
    }
  }

  void _onSubmitButtonPressed(BuildContext context) {
    if (_nameController.text.isEmpty) {
      _showEmptyNameSnackBar();
      return;
    }

    // Unfocus closes the keyboard automatically.
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<AgeEstimationCubit>().onNameSubmitted(_nameController.text);
  }

  void _showEmptyNameSnackBar() {
    const snackBar = SnackBar(content: Text('Pleaser enter a name first.'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  List<BoxShadow> get _shadow {
    return const [
      BoxShadow(
        color: Colors.black38,
        spreadRadius: 0,
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ];
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
