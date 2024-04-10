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
            decoration: const InputDecoration(
              hintText: 'First or full name',
            ),
          ),
        ),
        const SizedBox(width: 16),
        BlocBuilder<AgeEstimationCubit, AgeEstimationState>(
          builder: (context, state) {
            return IconButton.filled(
              onPressed: state is AgeEstimationLoading
                  ? null
                  : () {
                      context
                          .read<AgeEstimationCubit>()
                          .onNameSubmitted(_nameController.text);
                    },
              icon: const Icon(Icons.search),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
