import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: cs.surface,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const spacing = 16.0;

          int statCols;
          if (constraints.maxWidth >= 1100) {
            statCols = 3;
          } else if (constraints.maxWidth >= 740) {
            statCols = 2;
          } else {
            statCols = 1;
          }
          final statWidth =
              (constraints.maxWidth - spacing * (statCols - 1)) / statCols;

          final chartCols = constraints.maxWidth >= 1100 ? 2 : 1;
          final chartWidth =
              (constraints.maxWidth - spacing * (chartCols - 1)) / chartCols;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Row/Wrap: Kartu statistik
                Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: [
                    SizedBox(
                      width: statWidth,
                      child: StatCard(
                        title: 'Total Pemasukan',
                        value: '10 rb',
                        bgColor: const Color(0xFFE8F1FF),
                        iconColor: const Color(0xFF2979FF),
                        icon: Icons.addchart_outlined,
                      ),
                    ),
                    SizedBox(
                      width: statWidth,
                      child: StatCard(
                        title: 'Total Pengeluaran',
                        value: '2.1 rb',
                        bgColor: const Color(0xFFE9FFF3),
                        iconColor: const Color(0xFF16A34A),
                        icon: Icons.stacked_bar_chart_outlined,
                      ),
                    ),
                    SizedBox(
                      width: statWidth,
                      child: StatCard(
                        title: 'Jumlah Transaksi',
                        value: '2',
                        bgColor: const Color(0xFFFFF9DB),
                        iconColor: const Color(0xFFB45309),
                        icon: Icons.table_view_outlined,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: spacing),
                // Row/Wrap: Kartu chart
                Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: [
                    SizedBox(
                      width: chartWidth,
                      child: ChartCard(
                        title: 'Pemasukan per Bulan',
                        titleColor: const Color(0xFF7C3AED),
                        bgColor: const Color(0xFFF7E9FF),
                        barColor: const Color(0xFF22D3EE),
                        data: const [
                          MonthValue('Jun', 6.5),
                          MonthValue('Jul', 8.2),
                          MonthValue('Agu', 10.0),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: chartWidth,
                      child: ChartCard(
                        title: 'Pengeluaran per Bulan',
                        titleColor: const Color(0xFFDB2777),
                        bgColor: const Color(0xFFFFE8F1),
                        barColor: const Color(0xFFFB7185),
                        data: const [
                          MonthValue('Sep', 1.1),
                          MonthValue('Okt', 2.2),
                          MonthValue('Nov', 1.6),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color bgColor;
  final Color iconColor;
  final IconData icon;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.bgColor,
    required this.iconColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class MonthValue {
  final String month;
  final double value; // gunakan satuan "rb" seperti contoh
  const MonthValue(this.month, this.value);
}

class ChartCard extends StatelessWidget {
  final String title;
  final List<MonthValue> data;
  final Color bgColor;
  final Color barColor;
  final Color titleColor;

  const ChartCard({
    super.key,
    required this.title,
    required this.data,
    required this.bgColor,
    required this.barColor,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    final maxY = max<double>(
      1.0,
      data.fold<double>(0, (p, e) => max(p, e.value)) * 1.2,
    );

    return Container(
      height: 360,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Judul
          Row(
            children: [
              Icon(Icons.insert_chart_outlined, color: titleColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: titleColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: BarChart(
              BarChartData(
                maxY: maxY,
                gridData: FlGridData(
                  show: true,
                  horizontalInterval: maxY / 5,
                  drawVerticalLine: false,
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 42,
                      getTitlesWidget: (value, meta) {
                        // tampilkan dalam "rb"
                        return Text(
                          value.toStringAsFixed(1).replaceAll('.0', '') + ' rb',
                          style: const TextStyle(fontSize: 11),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final i = value.toInt();
                        if (i < 0 || i >= data.length) return const SizedBox();
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            data[i].month,
                            style: const TextStyle(fontSize: 12),
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: List.generate(
                  data.length,
                  (i) => BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: data[i].value,
                        color: barColor,
                        width: 28,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
