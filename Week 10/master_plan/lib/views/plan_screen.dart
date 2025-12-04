import 'package:flutter/material.dart';
import 'package:master_plan/provider/plan_provider.dart';
import '../models/data_layer.dart';

class PlanScreen extends StatefulWidget {
  final Plan plan;

  const PlanScreen({super.key, required this.plan});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  late ScrollController scrollController;

  Plan get plan => widget.plan;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        FocusScope.of(context).requestFocus(FocusNode());
      });
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<List<Plan>> plansNotifier = PlanProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(plan.name)),
      body: ValueListenableBuilder<List<Plan>>(
        valueListenable: plansNotifier,
        builder: (context, plans, child) {
          // ambil plan sesuai nama
          final currentPlan = plans.firstWhere((p) => p.name == plan.name);

          return Column(
            children: [
              Expanded(child: _buildList(currentPlan)),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(currentPlan.completenessMessage),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: _buildAddTaskButton(context),
    );
  }

  // ==========================
  // ADD TASK
  // ==========================
  Widget _buildAddTaskButton(BuildContext context) {
    final plansNotifier = PlanProvider.of(context);

    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        final updated = List<Plan>.from(plansNotifier.value);

        final index = updated.indexWhere((p) => p.name == plan.name);
        if (index == -1) return;

        updated[index] = Plan(
          name: updated[index].name,
          tasks: [...updated[index].tasks, const Task()],
        );

        plansNotifier.value = updated;
      },
    );
  }

  // ==========================
  // LIST BUILDER
  // ==========================
  Widget _buildList(Plan plan) {
    return ListView.builder(
      controller: scrollController,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: plan.tasks.length,
      itemBuilder: (context, index) => _buildTaskTile(plan.tasks[index], index),
    );
  }

  // ==========================
  // TASK TILE
  // ==========================
  Widget _buildTaskTile(Task task, int index) {
    final plansNotifier = PlanProvider.of(context);

    return ListTile(
      leading: Checkbox(
        value: task.complete,
        onChanged: (selected) {
          final updated = List<Plan>.from(plansNotifier.value);
          final i = updated.indexWhere((p) => p.name == plan.name);
          if (i == -1) return;

          final tasks = List<Task>.from(updated[i].tasks);
          tasks[index] = Task(
            description: task.description,
            complete: selected ?? false,
          );

          updated[i] = Plan(name: updated[i].name, tasks: tasks);

          plansNotifier.value = updated;
        },
      ),
      title: TextFormField(
        initialValue: task.description,
        onChanged: (text) {
          final updated = List<Plan>.from(plansNotifier.value);
          final i = updated.indexWhere((p) => p.name == plan.name);
          if (i == -1) return;

          final tasks = List<Task>.from(updated[i].tasks);
          tasks[index] = Task(description: text, complete: task.complete);

          updated[i] = Plan(name: updated[i].name, tasks: tasks);

          plansNotifier.value = updated;
        },
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
