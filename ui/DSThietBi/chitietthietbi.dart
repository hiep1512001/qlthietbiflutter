import 'package:flutter/material.dart';

class ChiTietThietBi extends StatelessWidget {
  const ChiTietThietBi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: Container(
          // padding: EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
              color: Colors.white),
          child: AppBar(
            bottom: null,
            backgroundColor: Colors.blue,
            title: Text(
              'Chi tiết thiết bị',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white, // Màu của icon
                size: 30.0, // Kích thước của icon
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DeviceSummaryCard(),
            const SizedBox(height: 16),
            _ActionButtons(),
            const SizedBox(height: 16),
            const _DeviceTabView(),
          ],
        ),
      ),
    );
  }
}

class _DeviceSummaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Máy X-Quang Kỹ Thuật Số',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: const [
                Text('Mã code: DEV-00123'),
                Chip(
                    label: Text('Đang sử dụng'),
                    backgroundColor: Colors.greenAccent),
                Text('Khoa: Chẩn đoán hình ảnh'),
                Text('Model: XQ-2021'),
                Text('Ngày nhập: 12/05/2023'),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.edit),
          label: const Text('Cập nhật'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
          ),
        ),
// Nút Chuyển khoa - Màu xanh
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.swap_horiz),
          label: const Text('Chuyển khoa'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),

// Nút Báo hỏng - Màu đỏ
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.report_problem),
          label: const Text('Báo hỏng'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _DeviceTabView extends StatefulWidget {
  const _DeviceTabView();

  @override
  State<_DeviceTabView> createState() => _DeviceTabViewState();
}

class _DeviceTabViewState extends State<_DeviceTabView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Chi tiết'),
            Tab(text: 'Lịch sử'),
            Tab(text: 'Bảo trì'),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 300,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildDetailTab(),
              _buildLogsTab(),
              _buildMaintenanceTab(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildDetailTab() {
    return ListView(
      children: const [
        ListTile(title: Text('Hãng sản xuất'), subtitle: Text('Fujifilm')),
        ListTile(
            title: Text('Mô tả'),
            subtitle: Text('Máy chụp X-quang kỹ thuật số cho phòng khám')),
        ListTile(title: Text('Hạn bảo hành'), subtitle: Text('12/05/2026')),
        ListTile(
            title: Text('Tài liệu đính kèm'),
            subtitle: Text('hoadon.pdf, bienban.docx')),
      ],
    );
  }

  Widget _buildLogsTab() {
    return ListView(
      children: const [
        ListTile(
            leading: Icon(Icons.history),
            title: Text('14/04/2025 - Điều chuyển đến khoa Nội A')),
        ListTile(
            leading: Icon(Icons.history),
            title: Text('02/01/2024 - Bảo trì định kỳ')),
      ],
    );
  }

  Widget _buildMaintenanceTab() {
    return ListView(
      children: const [
        ListTile(title: Text('Bảo trì gần nhất'), subtitle: Text('02/01/2024')),
        ListTile(title: Text('Lịch tiếp theo'), subtitle: Text('02/01/2025')),
        ListTile(
            title: Text('Ghi chú'),
            subtitle: Text('Kiểm tra nguồn điện, cáp kết nối')),
      ],
    );
  }
}
