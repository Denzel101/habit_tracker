import 'package:habit_tracker/constants/constants.dart';
import 'package:habit_tracker/home/home.dart';

final _workOut = ChooseHabitModel(
  image: AssetPath.runHabit,
  habit: 'Work Out',
);

final _eatFood = ChooseHabitModel(
  image: AssetPath.eatFoodHabit,
  habit: 'Eat Food',
);

final _music = ChooseHabitModel(
  image: AssetPath.musicHabit,
  habit: 'Music',
);

final _artAndDesign = ChooseHabitModel(
  image: AssetPath.artAndDesignHabit,
  habit: 'Art & Design',
);

final _travelling = ChooseHabitModel(
  image: AssetPath.travellingHabit,
  habit: 'Traveling',
);

final _readBook = ChooseHabitModel(
  image: AssetPath.readingHabit,
  habit: 'Read Book',
);

final _gaming = ChooseHabitModel(
  image: AssetPath.gamingHabit,
  habit: 'Gaming',
);

final _mechanic = ChooseHabitModel(
  image: AssetPath.mechanicHabit,
  habit: 'Mechanic',
);

final List<ChooseHabitModel> chooseHabits = [
  _workOut,
  _eatFood,
  _music,
  _artAndDesign,
  _travelling,
  _readBook,
  _gaming,
  _mechanic,
];
