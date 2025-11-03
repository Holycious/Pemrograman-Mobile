import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final bool collapsed;
  final VoidCallback onToggleCollapsed;

  const Sidebar({
    super.key,
    required this.collapsed,
    required this.onToggleCollapsed,
  });

  @override
  Widget build(BuildContext context) {
    final width = collapsed ? 76.0 : 280.0;

    return Container(
      width: width,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: Column(
        children: [
          _header(collapsed),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 12),
              children: [
                _item(
                  context,
                  icon: Icons.dashboard_outlined,
                  label: 'Dashboard',
                  active: true,
                ),
                _sectionTitle(collapsed, 'Menu Utama'),
                _item(
                  context,
                  icon: Icons.account_balance_wallet_outlined,
                  label: 'Keuangan',
                ),
                _item(
                  context,
                  icon: Icons.people_outline,
                  label: 'Data Warga & Rumah',
                ),
                _item(
                  context,
                  icon: Icons.receipt_long_outlined,
                  label: 'Pemasukan',
                ),
                _item(
                  context,
                  icon: Icons.outbox_outlined,
                  label: 'Pengeluaran',
                ),
                _item(
                  context,
                  icon: Icons.insert_chart_outlined_rounded,
                  label: 'Laporan Keuangan',
                ),
                _sectionTitle(collapsed, 'Lainnya'),
                _item(
                  context,
                  icon: Icons.campaign_outlined,
                  label: 'Kegiatan & Broadcast',
                ),
                _item(
                  context,
                  icon: Icons.chat_bubble_outline,
                  label: 'Pesan Warga',
                ),
                _item(
                  context,
                  icon: Icons.manage_accounts_outlined,
                  label: 'Manajemen Pengguna',
                ),
              ],
            ),
          ),
          _footer(collapsed),
        ],
      ),
    );
  }

  Widget _header(bool collapsed) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 12, 8),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFF635BFF).withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.menu_book_rounded,
              color: Color(0xFF635BFF),
            ),
          ),
          if (!collapsed) ...[
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Jawara Pintar.',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              tooltip: 'Collapse',
              icon: const Icon(Icons.chevron_left),
              onPressed: onToggleCollapsed,
            ),
          ] else
            IconButton(
              tooltip: 'Expand',
              icon: const Icon(Icons.chevron_right),
              onPressed: onToggleCollapsed,
            ),
        ],
      ),
    );
  }

  Widget _item(
    BuildContext context, {
    required IconData icon,
    required String label,
    bool active = false,
  }) {
    final color = active ? const Color(0xFF111827) : const Color(0xFF6B7280);
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: collapsed ? 12 : 16,
          vertical: 10,
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: color),
            if (!collapsed) ...[
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: active
                        ? const Color(0xFF111827)
                        : const Color(0xFF374151),
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right,
                size: 18,
                color: Color(0xFF9CA3AF),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(bool collapsed, String text) {
    if (collapsed) return const SizedBox(height: 8);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF9CA3AF),
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  Widget _footer(bool collapsed) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        collapsed ? 8 : 12,
        10,
        collapsed ? 8 : 12,
        16,
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundColor: Color(0xFFE5E7EB),
            child: Icon(Icons.person_outline, color: Color(0xFF6B7280)),
          ),
          if (!collapsed) ...[
            const SizedBox(width: 10),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Admin Jawara',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'admin1@gmail.com',
                    style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.chevron_right,
                size: 18,
                color: Color(0xFF9CA3AF),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
