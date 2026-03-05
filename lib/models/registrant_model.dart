// lib/models/registrant_model.dart

class Registrant {
  final String id;
  final String name;
  final String email;
  final String gender;
  final String programStudi;
  final DateTime dateOfBirth;
  final DateTime registeredAt;

  Registrant({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.programStudi,
    required this.dateOfBirth,
    DateTime? registeredAt,
  }) : registeredAt = registeredAt ?? DateTime.now();

  // Helper: hitung umur
  int get age {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  // Helper: format tanggal lahir
  String get formattedDateOfBirth {
    final months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    return '${dateOfBirth.day} ${months[dateOfBirth.month]} ${dateOfBirth.year}';
  }

  // Helper: format waktu registrasi
  String get formattedRegisteredAt {
    return '${registeredAt.day}/${registeredAt.month}/${registeredAt.year} '
        '${registeredAt.hour.toString().padLeft(2, '0')}:'
        '${registeredAt.minute.toString().padLeft(2, '0')}';
  }
}
