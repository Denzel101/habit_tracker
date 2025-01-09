import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:habit_tracker/constants/constants.dart';
import 'package:habit_tracker/helpers/helpers.dart';
import 'package:habit_tracker/home/home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _today = DateTime.now();
  var _selectedDay = DateTime.now();
  final _currentWeek = FunctionHelper.getCurrentWeek();

  @override
  void initState() {
    context.read<CompleteHabitDetailsCubit>().retrieveHabitDetails();
    context.read<UpdateHabitDetailsCubit>().retrieveHabitDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppStyles.kAppPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.07,
            ),
            TopInfoWidget(
              title: _today.toCurrMonthDay(),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Container(
              padding: const EdgeInsets.all(AppStyles.kAppPadding),
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.info_outline,
                      color: Colors.white54,
                      size: 13,
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.grey.shade900,
                        child: Image.asset(
                          AssetPath.readingHabit,
                          height: 40,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: size.height * 0.005,
                        children: [
                          Text(
                            'Notification!',
                            style: AppStyles.kTextLabelStyle3,
                          ),
                          Text(
                            'Now is the time to read the book,\nyou can '
                            'change it in settings.',
                            style: AppStyles.kTextLabelStyle2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: _currentWeek.length,
                itemBuilder: (context, index) {
                  final item = _currentWeek[index];
                  final isSelected =
                      _selectedDay.toCurrMonthDay() == item.toCurrMonthDay();
                  return GestureDetector(
                    onTap: () {
                      _selectedDay = item;
                      setState(() {});
                    },
                    child: Container(
                      height: 90,
                      width: 65,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppStyles.kAppPadding,
                      ),
                      margin:
                          const EdgeInsets.only(right: AppStyles.kAppPadding),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.activeColor
                            : Colors.transparent,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Text(
                            item.toShortDay(),
                            style: AppStyles.kTextLabelStyle1.copyWith(
                              fontSize: 13,
                              color: isSelected
                                  ? Colors.white54
                                  : AppColors.textGrey,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            item.toNumDay(),
                            style: AppStyles.kTextLabelStyle1.copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.textGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${_selectedDay.toFullDay()} habit',
                  style: AppStyles.kTextLabelStyle1.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'See all',
                  style: AppStyles.kTextLabelStyle1.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            BlocBuilder<UpdateHabitDetailsCubit, UpdateHabitDetailsState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: SizedBox.new,
                  loaded: (response) {
                    final filteredList =
                        response.result.filterHabits(_selectedDay);

                    return response.result.isEmpty
                        ? Center(
                            child: Text(
                              'Nothing to see here 😊',
                              style: AppStyles.kTextLabelStyle2
                                  .copyWith(color: Colors.black),
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
                                      (habit) => habit.day
                                          .isAtSameMomentAs(_selectedDay),
                                      orElse: () => CompletedHabitModel(
                                        day: _selectedDay,
                                        habits: [],
                                      ),
                                    );

                                    final isSelected = completedHabitsForDay
                                        .habits
                                        .contains(item);
                                    return Container(
                                      height: 170,
                                      width: 150,
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFAEDE6),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                  final updatedHabits = List<
                                                      CreateHabitModel>.from(
                                                    completedHabitsForDay
                                                        .habits,
                                                  );

                                                  if (isSelected) {
                                                    updatedHabits.remove(item);
                                                  } else {
                                                    updatedHabits.add(item);
                                                  }

                                                  context
                                                      .read<
                                                          CompleteHabitDetailsCubit>()
                                                      .completeHabitDetails(
                                                        completedHabit:
                                                            CompletedHabitModel(
                                                          day: _selectedDay,
                                                          habits: updatedHabits,
                                                        ),
                                                      );

                                                  setState(() {});
                                                },
                                                child: Container(
                                                  height: 25,
                                                  width: 25,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
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
                                            style: AppStyles.kTextLabelStyle3
                                                .copyWith(
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            item.description,
                                            style: AppStyles.kTextLabelStyle1
                                                .copyWith(
                                              fontSize: 13,
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
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
          ].animate(
            interval: const Duration(milliseconds: 50),
            effects: [
              const FadeEffect(),
              const SlideEffect(),
            ],
          ),
        ),
      ),
    );
  }
}
