import 'package:flutter/material.dart';

class CourtsScreen extends StatelessWidget {
  const CourtsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1200;

    final courts = [
      {
        'id': 'CT001',
        'name': 'Tennis Court 1',
        'location': 'Sports Complex A',
        'type': 'Tennis',
        'active': true,
        'approved': true,
      },
      {
        'id': 'CT002',
        'name': 'Tennis Court 2',
        'location': 'Sports Complex A',
        'type': 'Tennis',
        'active': true,
        'approved': true,
      },
      {
        'id': 'CT003',
        'name': 'Basketball Court 1',
        'location': 'Sports Complex B',
        'type': 'Basketball',
        'active': false,
        'approved': true,
      },
      {
        'id': 'CT004',
        'name': 'Badminton Court 1',
        'location': 'Sports Complex A',
        'type': 'Badminton',
        'active': true,
        'approved': false,
      },
      {
        'id': 'CT005',
        'name': 'Squash Court 1',
        'location': 'Sports Complex C',
        'type': 'Squash',
        'active': false,
        'approved': true,
      },
      {
        'id': 'CT006',
        'name': 'Volleyball Court 1',
        'location': 'Sports Complex B',
        'type': 'Volleyball',
        'active': true,
        'approved': true,
      },
      {
        'id': 'CT007',
        'name': 'Tennis Court 3',
        'location': 'Sports Complex A',
        'type': 'Tennis',
        'active': false,
        'approved': false,
      },
      {
        'id': 'CT008',
        'name': 'Basketball Court 2',
        'location': 'Sports Complex B',
        'type': 'Basketball',
        'active': true,
        'approved': true,
      },
    ];

    if (isMobile) {
      return _buildMobileView(courts);
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: isTablet ? 16 : 24,
          columns: [
            DataColumn(
              label: Text(
                'Court ID',
                style: TextStyle(fontSize: isTablet ? 12 : 14),
              ),
            ),
            DataColumn(
              label: Text(
                'Name',
                style: TextStyle(fontSize: isTablet ? 12 : 14),
              ),
            ),
            DataColumn(
              label: Text(
                'Location',
                style: TextStyle(fontSize: isTablet ? 12 : 14),
              ),
            ),
            DataColumn(
              label: Text(
                'Type',
                style: TextStyle(fontSize: isTablet ? 12 : 14),
              ),
            ),
            DataColumn(
              label: Text(
                'Active',
                style: TextStyle(fontSize: isTablet ? 12 : 14),
              ),
            ),
            DataColumn(
              label: Text(
                'Approved',
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
          rows: courts.map((court) {
            return DataRow(
              cells: [
                DataCell(
                  Container(
                    width: isTablet ? 70 : 100,
                    child: Text(
                      court['id'] as String,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: isTablet ? 11 : 13),
                    ),
                  ),
                ),
                DataCell(
                  Container(
                    width: isTablet ? 120 : 150,
                    child: Text(
                      court['name'] as String,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: isTablet ? 11 : 13),
                    ),
                  ),
                ),
                DataCell(
                  Container(
                    width: isTablet ? 120 : 150,
                    child: Text(
                      court['location'] as String,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: isTablet ? 11 : 13),
                    ),
                  ),
                ),
                DataCell(
                  Container(
                    width: isTablet ? 80 : 100,
                    child: Text(
                      court['type'] as String,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: isTablet ? 11 : 13),
                    ),
                  ),
                ),
                DataCell(
                  Container(
                    width: isTablet ? 60 : 80,
                    child: Icon(
                      (court['active'] as bool)
                          ? Icons.check_circle
                          : Icons.cancel,
                      color: (court['active'] as bool)
                          ? Colors.green
                          : Colors.red,
                      size: 20,
                    ),
                  ),
                ),
                DataCell(
                  Container(
                    width: isTablet ? 60 : 80,
                    child: Icon(
                      (court['approved'] as bool)
                          ? Icons.check_circle
                          : Icons.cancel,
                      color: (court['approved'] as bool)
                          ? Colors.green
                          : Colors.red,
                      size: 20,
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
                          backgroundColor: Colors.blue,
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
                          'Edit',
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
                          'Delete',
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

  Widget _buildMobileView(List<Map<String, dynamic>> courts) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: courts.length,
      itemBuilder: (context, index) {
        final court = courts[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${court['name']} (${court['id']})',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text('Location: ${court['location']}'),
                Text('Type: ${court['type']}'),
                Row(
                  children: [
                    Text('Active: '),
                    Icon(
                      (court['active'] as bool)
                          ? Icons.check_circle
                          : Icons.cancel,
                      color: (court['active'] as bool)
                          ? Colors.green
                          : Colors.red,
                      size: 16,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Approved: '),
                    Icon(
                      (court['approved'] as bool)
                          ? Icons.check_circle
                          : Icons.cancel,
                      color: (court['approved'] as bool)
                          ? Colors.green
                          : Colors.red,
                      size: 16,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Edit'),
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
                        child: const Text('Delete'),
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
}
