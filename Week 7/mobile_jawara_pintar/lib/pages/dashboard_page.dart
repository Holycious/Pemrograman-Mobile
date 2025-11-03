import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool sidebarCollapsed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Sidebar(
              collapsed: sidebarCollapsed,
              onToggleCollapsed: () =>
                  setState(() => sidebarCollapsed = !sidebarCollapsed),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.dashboard_outlined,
                      size: 48,
                      color: Color(0xFF9CA3AF),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF374151),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(''),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
