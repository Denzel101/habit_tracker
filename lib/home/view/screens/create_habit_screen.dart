import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/components/components.dart';
import 'package:habit_tracker/constants/constants.dart';
import 'package:habit_tracker/helpers/helpers.dart';
import 'package:habit_tracker/home/home.dart';
import 'package:habit_tracker/router/router.dart';

class CreateHabitScreen extends StatefulWidget {
  const CreateHabitScreen({required this.chosenHabit, super.key});
  final ChooseHabitModel chosenHabit;

  @override
  State<CreateHabitScreen> createState() => _CreateHabitScreenState();
}

class _CreateHabitScreenState extends State<CreateHabitScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<CreateHabitModel> _createdHabits = [];
  String? _selectedFrequency;
  DateTime? _selectedDateTime;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppStyles.kAppPadding),
        child: SizedBox(
          width: size.width,
          child: BlockButtonWidget(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _createdHabits.add(
                  CreateHabitModel(
                    habitName: _nameController.text,
                    description: _descriptionController.text,
                    frequency: _selectedFrequency!,
                    startDate: _selectedDateTime!,
                    habitIcon: widget.chosenHabit.image,
                    habitLabel: widget.chosenHabit.habit,
                  ),
                );

                context
                    .read<UpdateHabitDetailsCubit>()
                    .updateHabitDetails(createdHabits: _createdHabits);

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRouter.landingRoute,
                  (route) => false,
                );
              }
            },
            child: Text(
              'Continue',
              style: AppStyles.kTextLabelStyle3,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppStyles.kAppPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.07,
              ),
              Text(
                'Create habit',
                style: AppStyles.kTextLabelStyle1.copyWith(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                'Create your daily habit, you are creating\na '
                '${widget.chosenHabit.habit.toLowerCase()} one',
                style: AppStyles.kTextLabelStyle2.copyWith(
                  color: AppColors.textGrey,
                  fontSize: 13,
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              CustomTextField(
                label: 'Habit Name*',
                hintText: 'Enter habit name',
                keyBoard: TextInputType.name,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Add Habit Name';
                  }
                  return null;
                },
                textEditingController: _nameController,
              ),
              SizedBox(
                height: size.height * 0.016,
              ),
              CustomTextField(
                label: 'Description*',
                hintText: 'Enter description',
                keyBoard: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Add Description';
                  }
                  return null;
                },
                textEditingController: _descriptionController,
              ),
              SizedBox(
                height: size.height * 0.016,
              ),
              CustomDropDownField<String>(
                contentPadding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppStyles.kAppPadding,
                ),
                label: 'Frequency*',
                hint: 'Select frequency',
                value: _selectedFrequency,
                items: [
                  for (final item in frequency)
                    DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                ],
                validator: (value) {
                  if (value == null) {
                    return 'Select frequency';
                  }
                  return null;
                },
                onChanged: (value) {
                  _selectedFrequency = value;
                },
              ),
              SizedBox(
                height: size.height * 0.016,
              ),
              CustomTextField(
                onTap: () async {
                  final result = await FunctionHelper.selectStartDate(context);
                  _selectedDateTime = result;
                  _dateController.text =
                      '${result.day}-${result.month}-${result.year}';
                  setState(() {});
                },
                label: 'Start Date*',
                hintText: 'Enter start date',
                keyBoard: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Add start date';
                  }
                  return null;
                },
                textEditingController: _dateController,
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
