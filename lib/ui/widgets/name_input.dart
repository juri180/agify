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
          child: TextField(
            controller: _nameController,
            onSubmitted: (_) {
              _onKeyboardSubmitPressed(context);
            },
            decoration: const InputDecoration(
              hintText: 'First or full name',
            ),
          ),
        ),
        const SizedBox(width: 16),
        BlocBuilder<AgeEstimationCubit, AgeEstimationState>(
          builder: (context, state) {
            return IconButton.filled(
              icon: const Icon(Icons.search),
              onPressed: state is AgeEstimationLoading
                  ? null
                  : () {
                      _onSubmitButtonPressed(context);
                    },
            );
          },
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

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
