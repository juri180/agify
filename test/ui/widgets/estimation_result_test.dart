import 'package:agify/data/models/age_estimate.dart';
import 'package:agify/data/models/estimation_failure.dart';
import 'package:agify/logic/age_estimation_cubit.dart';
import 'package:agify/ui/widgets/estimation_result.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAgeEstimationCubit extends MockCubit<AgeEstimationState>
    implements AgeEstimationCubit {}

void main() {
  group('EstimationResult', () {
    late AgeEstimationCubit cubit;

    setUp(() {
      cubit = MockAgeEstimationCubit();
    });

    testWidgets(
      'renders shrinked SizedBox for AgeEstimationInitial',
      (widgetTester) async {
        when(() => cubit.state).thenReturn(AgeEstimationInitial());

        await widgetTester.pumpWidget(
          BlocProvider.value(
            value: cubit,
            child: const EstimationResult(),
          ),
        );

        expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is SizedBox && widget.width == 0 && widget.height == 0,
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'renders CircularProgressIndicator for AgeEstimationLoading',
      (widgetTester) async {
        when(() => cubit.state).thenReturn(AgeEstimationLoading());

        await widgetTester.pumpWidget(
          BlocProvider.value(
            value: cubit,
            child: const EstimationResult(),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'renders correct Text for AgeEstimationSuccessful',
      (widgetTester) async {
        const estimate = AgeEstimate(name: 'John Doe', age: 73);
        when(() => cubit.state)
            .thenReturn(const AgeEstimationSuccessful(estimate));

        await widgetTester.pumpWidget(
          BlocProvider.value(
            value: cubit,
            child: const MaterialApp(home: EstimationResult()),
          ),
        );

        expect(find.text('John Doe is 73 years old.'), findsOneWidget);
      },
    );

    testWidgets(
      'renders correct Text for AgeEstimationFailed',
      (widgetTester) async {
        const failure = EstimationFailure('No internet connection.');
        when(() => cubit.state).thenReturn(const AgeEstimationFailed(failure));

        await widgetTester.pumpWidget(
          BlocProvider.value(
            value: cubit,
            child: const MaterialApp(home: EstimationResult()),
          ),
        );

        expect(find.text('No internet connection.'), findsOneWidget);
      },
    );
  });
}
