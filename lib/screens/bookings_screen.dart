import 'package:flutter/material.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1200;

    final bookings = [
      {
        'id': 'tk8qHjTRG9SrohzMoS3G',
        'venue': '0LY5ryfUXTh2eZxh50Ph',
        'user': 'd80wKZRdtfWb43QQEJ8fOxdjvMha2',
        'start': '2025-07-25 09:00:00.000',
        'end': '2025-07-25 10:00:00.000',
        'status': 'confirmed',
      },
      {
        'id': '7oO1tYJ5RtnXZwS9TMk',
        'venue': '0LY5ryfUXTh2eZxh50Ph',
        'user': 'd80wKZRdtfWb43QQEJ8fOxdjvMha2',
        'start': '2025-07-22 15:00:00.000',
        'end': '2025-07-22 16:00:00.000',
        'status': 'confirmed',
      },
      {
        'id': 'aZkQ4o7MVod0QzGjhDfg',
        'venue': '0LY5ryfUXTh2eZxh50Ph',
        'user': 'd80wKZRdtfWb43QQEJ8fOxdjvMha2',
        'start': '2025-07-22 06:00:00.000',
        'end': '2025-07-22 07:00:00.000',
        'status': 'confirmed',
      },
      {
        'id': '9hyLHnWltqX0gGoZpCaU',
        'venue': '0LY5ryfUXTh2eZxh50Ph',
        'user': 'd80wKZRdtfWb43QQEJ8fOxdjvMha2',
        'start': '2025-07-22 01:00:00.000',
        'end': '2025-07-22 02:00:00.000',
        'status': 'confirmed',
      },
      {
        'id': 'vhkf9aZ9QZtbQmy3EES5',
        'venue': '0LY5ryfUXTh2eZxh50Ph',
        'user': 'd80wKZRdtfWb43QQEJ8fOxdjvMha2',
        'start': '2025-07-22 09:00:00.000',
        'end': '2025-07-22 10:00:00.000',
        'status': 'confirmed',
      },
      {
        'id': 'TlTBxqpF16pElzuu2Ir',
        'venue': '0LY5ryfUXTh2eZxh50Ph',
        'user': 'd80wKZRdtfWb43QQEJ8fOxdjvMha2',
        'start': '2025-07-24 09:00:00.000',
        'end': '2025-07-24 10:00:00.000',
        'status': 'confirmed',
      },
      {
        'id': 'tPndMfnVeLCPxYS83WRG',
        'venue': 'TbiYcHcRKAoRqaqHSQ0U',
        'user': 'd80wKZRdtfWb43QQEJ8fOxdjvMha2',
        'start': '2025-07-27 07:00:00.000',
        'end': '2025-07-27 08:00:00.000',
        'status': 'confirmed',
      },
      {
        'id': 'nGA6cPoRp9J4JytbnTQm',
        'venue': 'TbiYcHcRKAoRqaqHSQ0U',
        'user': 'd80wKZRdtfWb43QQEJ8fOxdjvMha2',
        'start': '2025-07-21 04:00:00.000',
        'end': '2025-07-21 05:00:00.000',
        'status': 'cancelled',
      },
      {
        'id': 'Yr1BSDiHU0sXe3DjXQ1H',
        'venue': 'TbiYcHcRKAoRqaqHSQ0U',
        'user': 'd80wKZRdtfWb43QQEJ8fOxdjvMha2',
        'start': '2025-07-21 09:00:00.000',
        'end': '2025-07-21 10:00:00.000',
        'status': 'expired',
      },
      {
        'id': 'KRo8qFtFsDFlF0KC07L8',
        'venue': 'TbiYcHcRKAoRqaqHSQ0U',
        'user': 'd80wKZRdtfWb43QQEJ8fOxdjvMha2',
        'start': '2025-07-21 09:00:00.000',
        'end': '2025-07-21 10:00:00.000',
        'status': 'expired',
      },
    ];

    if (isMobile) {
      return _buildMobileView(bookings);
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: isTablet ? 16 : 24,
          columns: [
            DataColumn(
              label: Text('ID', style: TextStyle(fontSize: isTablet ? 12 : 14)),
            ),
            DataColumn(
              label: Text(
                'Venue',
                style: TextStyle(fontSize: isTablet ? 12 : 14),
              ),
            ),
            DataColumn(
              label: Text(
                'User',
                style: TextStyle(fontSize: isTablet ? 12 : 14),
              ),
            ),
            DataColumn(
              label: Text(
                'Start',
                style: TextStyle(fontSize: isTablet ? 12 : 14),
              ),
            ),
            DataColumn(
              label: Text(
                'End',
                style: TextStyle(fontSize: isTablet ? 12 : 14),
              ),
            ),
            DataColumn(
              label: Text(
                'Status',
                style: TextStyle(fontSize: isTablet ? 12 : 14),
              ),
            ),
            DataColumn(
              label: Text(
                'Actions',
                style: TextStyle(fontSize: isTablet ? 12 : 14),
              ),
            ),
          ],
          rows: bookings.map((booking) {
            return DataRow(
              cells: [
                DataCell(
                  Container(
                    width: isTablet ? 80 : 120,
                    child: Text(
                      booking['id']!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: isTablet ? 11 : 13),
                    ),
                  ),
                ),
                DataCell(
                  Container(
                    width: isTablet ? 80 : 120,
                    child: Text(
                      booking['venue']!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: isTablet ? 11 : 13),
                    ),
                  ),
                ),
                DataCell(
                  Container(
                    width: isTablet ? 100 : 160,
                    child: Text(
                      booking['user']!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: isTablet ? 11 : 13),
                    ),
                  ),
                ),
                DataCell(
                  Container(
                    width: isTablet ? 120 : 150,
                    child: Text(
                      booking['start']!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: isTablet ? 11 : 13),
                    ),
                  ),
                ),
                DataCell(
                  Container(
                    width: isTablet ? 120 : 150,
                    child: Text(
                      booking['end']!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: isTablet ? 11 : 13),
                    ),
                  ),
                ),
                DataCell(
                  Container(
                    width: isTablet ? 70 : 90,
                    child: Text(
                      booking['status']!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: isTablet ? 11 : 13),
                    ),
                  ),
                ),
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: isTablet ? 8 : 12,
                            vertical: 6,
                          ),
                          minimumSize: Size(isTablet ? 60 : 70, 32),
                        ),
                        child: Text(
                          'Confirm',
                          style: TextStyle(fontSize: isTablet ? 10 : 12),
                        ),
                      ),
                      SizedBox(width: isTablet ? 4 : 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: isTablet ? 8 : 12,
                            vertical: 6,
                          ),
                          minimumSize: Size(isTablet ? 60 : 70, 32),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: isTablet ? 10 : 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildMobileView(List<Map<String, String>> bookings) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'ID: ${booking['id']}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(booking['status']!),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        booking['status']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Venue: ${booking['venue']}'),
                Text('User: ${booking['user']}'),
                Text('Start: ${booking['start']}'),
                Text('End: ${booking['end']}'),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Confirm'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'confirmed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'expired':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
