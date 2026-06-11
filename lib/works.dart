import 'package:flutter/material.dart';
import 'package:todolist/modelbutton.dart';
import 'package:todolist/workscreen.dart';
import 'package:todolist/models/work.dart';

class MainWork extends StatefulWidget {
  const MainWork({super.key});

  @override
  State<MainWork> createState() => _WorksState();
}

class _WorksState extends State<MainWork> {
  List<Weeks> weeks = [
    Weeks('شنبه', Color.fromARGB(255, 242, 174, 187)),
    Weeks('یکشنبه', Color.fromARGB(255, 167, 170, 255)),
    Weeks('دوشنبه', Color.fromARGB(255, 163, 220, 154)),
    Weeks('سه شنبه', Color.fromARGB(255, 250, 218, 122)),
    Weeks('چهارشنبه', Color.fromARGB(255, 191, 236, 255)),
    Weeks('پنچ شنبه', Color.fromARGB(255, 255, 179, 142)),
    Weeks('جمعه', Color.fromARGB(255, 160, 196, 157)),
  ];
  // List<Works> work = [
  //   Works([]),
  //   Works([]),
  //   Works([]),
  //   Works([]),
  //   Works([]),
  //   Works([]),
  //   Works([]),
  // ];

  // void _addwork(String works, String day) {
  //   int index = weeks.indexWhere((w) => w.name == day);
  //   setState(() {
  //     work[index].works.add(works);
  //   });
  // }

  // void _remove(int index, String workname) {
  //   setState(() {
  //     work[index].works.remove(workname);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    void _openmodelbutton() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => Modelbutton(weeks),
      );
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('مدیریت کارها'),
          actions: [
            TextButton(
              onPressed: _openmodelbutton,

              child: Text("+", style: TextStyle(fontSize: 20)),
            ),
          ],
          elevation: 5,
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            Expanded(
              child: Workscreen(weeks: weeks),
            ),
          ],
        ),
      ),
    );
  }
}
