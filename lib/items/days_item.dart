import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/models/work.dart';
import 'package:todolist/provider/works_provider.dart';

class DaysItem extends ConsumerStatefulWidget {
  const DaysItem(this.name, this.color, this.work, this.dayIndex, {super.key});

  final String name;
  final Color color;
  final Works work;
  final int dayIndex;

  @override
  ConsumerState<DaysItem> createState() => _DaysItemState();
}

class _DaysItemState extends ConsumerState<DaysItem> {
  late Map<String, bool> checkedMap;

  @override
  void initState() {
    super.initState();
    checkedMap = {for (var w in widget.work.works) w: false};
  }

  @override
  void didUpdateWidget(covariant DaysItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    for (var w in widget.work.works) {
      checkedMap.putIfAbsent(w, () => false);
    }
    checkedMap.removeWhere((key, value) => !widget.work.works.contains(key));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.color,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.name,
              style: const TextStyle(
                fontFamily: 'vazir',
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            if (widget.work.works.isEmpty) const SizedBox(height: 15),
            Text(
              widget.work.works.isEmpty
                  ? 'هیچ کاری برای انجام دادن نداری :)'
                  : '',
              style: const TextStyle(
                color: Color.fromARGB(255, 118, 118, 118),
                fontFamily: 'vazir',
              ),
            ),
            const SizedBox(height: 20),

            // چک‌باکس‌ها
            ...widget.work.works.map((workName) {
              return CheckboxListTile(
                title: Text(
                  workName,
                  style: const TextStyle(
                    fontFamily: 'vazir',
                    fontSize: 13,
                    color: Color.fromARGB(255, 68, 68, 68),
                  ),
                ),
                value: checkedMap[workName] ?? false,
                onChanged: (v) {
                  setState(() {
                    checkedMap[workName] = v ?? false;
                  });
                },
                secondary: IconButton(
                  onPressed: () {
                    ref
                        .read(worksProvider.notifier)
                        .remove(workName, widget.dayIndex);
                    setState(() {
                      checkedMap.remove(workName);
                    });
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}