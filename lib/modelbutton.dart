import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/models/work.dart';
import 'package:todolist/provider/works_provider.dart';

class Modelbutton extends ConsumerStatefulWidget {
  const Modelbutton(this.weeks, {super.key});
  final List<Weeks> weeks;

  @override
  ConsumerState<Modelbutton> createState() => _ModelbuttonState();
}

class _ModelbuttonState extends ConsumerState<Modelbutton> {
  final _controller = TextEditingController();

  late String selected;
  int selectedindex = 0;

  @override
  void initState() {
    super.initState();
    selected = widget.weeks[0].name;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            TextField(
              controller: _controller,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                hintText: 'فعالیت مورد نظر خود را وارد کنید',
                labelText: 'فعالیت',
              ),
            ),

            const SizedBox(height: 30),

            Row(
              children: [
                const Text('یک روز از هفته را انتخاب کن'),

                const SizedBox(width: 20),

                DropdownMenu(
                  initialSelection: selected,
                  dropdownMenuEntries: widget.weeks
                      .map(
                        (e) => DropdownMenuEntry(
                          value: e.name,
                          label: e.name,
                        ),
                      )
                      .toList(),
                  onSelected: (value) {
                    if (value == null) return;

                    selected = value;

                    selectedindex = widget.weeks.indexWhere(
                      (w) => w.name == selected,
                    );

                    setState(() {});
                  },
                ),
              ],
            ),

            const SizedBox(height: 50),

            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isEmpty) return;

                    ref.read(worksProvider.notifier).add(
                          _controller.text,
                          selectedindex,
                        );

                    Navigator.pop(context);
                  },
                  child: const Text('ثبت کن'),
                ),

                const SizedBox(width: 20),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('کنسل'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}