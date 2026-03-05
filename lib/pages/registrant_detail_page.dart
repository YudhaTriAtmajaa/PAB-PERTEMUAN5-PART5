// lib/pages/registrant_detail_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/registration_provider.dart';

class RegistrantDetailPage extends StatelessWidget {
  const RegistrantDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final registrant = context.read<RegistrationProvider>().getById(id);

    if (registrant == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Not Found')),
        body: const Center(child: Text('Pendaftar tidak ditemukan')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(registrant.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Avatar
            CircleAvatar(
              radius: 50,
              child: Text(
                registrant.name[0].toUpperCase(),
                style: const TextStyle(fontSize: 36),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              registrant.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Terdaftar: ${registrant.formattedRegisteredAt}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // Info Cards
            _buildInfoCard(Icons.email, 'Email', registrant.email),
            _buildInfoCard(Icons.person, 'Gender', registrant.gender),
            _buildInfoCard(
              Icons.school,
              'Program Studi',
              registrant.programStudi,
            ),
            _buildInfoCard(
              Icons.cake,
              'Tanggal Lahir',
              '${registrant.formattedDateOfBirth} (${registrant.age} tahun)',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
