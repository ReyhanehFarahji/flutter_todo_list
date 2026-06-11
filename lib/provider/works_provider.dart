import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:todolist/models/work.dart';

class WorksNotifier extends StateNotifier<List<Works>> {
  WorksNotifier() : super(List.generate(7, (_) => Works([])));

  void add(String workName, int dayIndex) {
    if (dayIndex < 0 || dayIndex >= state.length) return;

    final updatedState = [...state];

    final dayWorks = List<String>.from(updatedState[dayIndex].works);
    dayWorks.add(workName);

    updatedState[dayIndex] = Works(dayWorks);

    state = updatedState;
  }

  void remove(String workName, int dayIndex) {
    if (dayIndex < 0 || dayIndex >= state.length) return;

    final updatedState = [...state];

    final dayWorks = List<String>.from(updatedState[dayIndex].works);
    dayWorks.remove(workName);

    updatedState[dayIndex] = Works(dayWorks);

    state = updatedState;
  }
}

final worksProvider = StateNotifierProvider<WorksNotifier, List<Works>>(
  (ref) => WorksNotifier(),
);
