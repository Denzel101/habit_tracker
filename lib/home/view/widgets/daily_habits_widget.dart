import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:habit_tracker/constants/constants.dart';
import 'package:habit_tracker/home/home.dart';

class DailyHabitsWidget extends StatefulWidget {
  const DailyHabitsWidget({required this.selectedDay, super.key});

  final DateTime selectedDay;

  @override
  State<DailyHabitsWidget> createState() => _DailyHabitsWidgetState();
}

class _DailyHabitsWidgetState extends State<DailyHabitsWidget> {
  bool isSameDay({required DateTime date1, required DateTime date2}) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateHabitDetailsCubit, UpdateHabitDetailsState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: SizedBox.new,
          loaded: (response) {
            final filteredList =
                response.result.filterHabits(widget.selectedDay);

            return response.result.isEmpty
                ? Center(
                    child: Text(
                      'Nothing to see here 😊',
                      style: AppStyles.kTextLabelStyle2,
                    ),
                  )
                : BlocBuilder<CompleteHabitDetailsCubit,
                    CompleteHabitDetailsState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: SizedBox.new,
                        loaded: (result) => AlignedGridView.count(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          shrinkWrap: true,
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            final item = filteredList[index];

                            final completedHabitsForDay =
                                result.completedHabits.firstWhere(
                              (habit) => isSameDay(
                                date1: habit.day,
                                date2: widget.selectedDay,
                              ),
                              orElse: () => CompletedHabitModel(
                                day: widget.selectedDay,
                                habits: [],
                              ),
                            );

                            final isSelected =
                                completedHabitsForDay.habits.contains(item);
                            return Container(
                              height: 170,
                              width: 150,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: context.isDarkMode
                                    ? Colors.redAccent
                                    : Colors.redAccent.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        item.habitIcon,
                                        height: 40,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          final updatedHabits =
                                              List<CreateHabitModel>.from(
                                            completedHabitsForDay.habits,
                                          );

                                          if (isSelected) {
                                            updatedHabits.remove(item);
                                          } else {
                                            updatedHabits.add(item);
                                          }

                                          context
                                              .read<CompleteHabitDetailsCubit>()
                                              .completeHabitDetails(
                                                completedHabit:
                                                    CompletedHabitModel(
                                                  day: widget.selectedDay,
                                                  habits: updatedHabits,
                                                ),
                                              );

                                          setState(() {});
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          decoration: BoxDecoration(
                                            color: context.isDarkMode
                                                ? Colors.grey.shade500
                                                : Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.check,
                                            color: isSelected
                                                ? Colors.deepOrange
                                                : AppColors.greyColor,
                                            size: 17,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                    item.habitName,
                                    style:
                                        AppStyles.kTextLabelStyle3.copyWith(),
                                  ),
                                  Text(
                                    item.description,
                                    style: AppStyles.kTextLabelStyle1.copyWith(
                                      fontSize: 13,
                                      color: context.isDarkMode
                                          ? Colors.grey.shade800
                                          : AppColors.textGrey,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
          },
        );
      },
    );
  }
}
