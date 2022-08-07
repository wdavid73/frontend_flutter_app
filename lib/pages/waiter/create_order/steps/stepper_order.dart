import 'package:flutter/material.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/button_tap.dart';

class StepperOrder extends StatefulWidget {
  final List<Step> steps;
  final int currentStep;
  final bool loading;
  final void Function()? onNextStep;
  final void Function()? onBackStep;
  final void Function()? onFinalStep;

  const StepperOrder({
    Key? key,
    required this.steps,
    required this.onNextStep,
    required this.onBackStep,
    required this.onFinalStep,
    this.currentStep = 0,
    this.loading = false,
  }) : super(key: key);

  @override
  State<StepperOrder> createState() => _StepperOrderState();
}

class _StepperOrderState extends State<StepperOrder> {
  final StepperType _stepperType = StepperType.vertical;

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    return SizedBox(
      child: Stepper(
        steps: widget.steps,
        currentStep: widget.currentStep,
        type: _stepperType,
        physics: const ScrollPhysics(),
        onStepTapped: (step) => changeStep(step),
        onStepContinue: nextStep,
        onStepCancel: backStep,
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              widget.currentStep < 2 ?
              ButtonTap(
                text: "Next Step",
                onPressed: details.onStepContinue,
                width: responsive.wp(35),
              ) :
              ButtonTap(
                text: "Create Order",
                onPressed: details.onStepContinue,
                width: responsive.wp(41),
                isLoading: widget.loading,
              ),

              ButtonTap(
                text: "Back Step",
                onPressed: details.onStepCancel,
                width: responsive.wp(36),
              ),
            ],
          );
        },
      ),
    );
  }

  changeStep(int step) {
    print(
      'change step -> $step',
    );
  }

  nextStep() {
    if (widget.currentStep < 2) {
      widget.onNextStep!();
    } else {
      widget.onFinalStep!();
    }
    print('next step');
  }

  backStep() {
    widget.onBackStep!();
    print('back step');
  }
}
