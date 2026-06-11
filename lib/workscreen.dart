import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/models/work.dart';
import 'package:todolist/items/days_item.dart';
import 'package:todolist/provider/works_provider.dart';

class Workscreen extends ConsumerStatefulWidget {
  const Workscreen({super.key, required this.weeks});

  final List<Weeks> weeks;

  @override
  ConsumerState<Workscreen> createState() => _WorkscreenState();
}

class _WorkscreenState extends ConsumerState<Workscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final worksList = ref.watch(worksProvider);

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: widget.weeks.length,
      itemBuilder: (ctx, index) {
        final double start = index * 0.1;
        final double end = start + 0.5;

        final Animation<double> animation = CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            start.clamp(0.0, 1.0),
            end.clamp(0.0, 1.0),
            curve: Curves.easeOut,
          ),
        );

        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Opacity(
              opacity: animation.value,
              child: Transform.translate(
                offset: Offset(0, 50 * (1 - animation.value)),
                child: child,
              ),
            );
          },
          child: DaysItem(
            widget.weeks[index].name,
            widget.weeks[index].color,
            worksList[index],
            index,
          ),
        );
      },
    );
  }
}