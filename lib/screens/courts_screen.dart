import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourtsScreen extends StatelessWidget {
  const CourtsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1200;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('venues').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No courts found.'));
        }

        final courts = snapshot.data!.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          // Optionally add the document ID if needed
          data['id'] = doc.id;
          return data;
        }).toList();

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
                      SizedBox(
                        width: isTablet ? 70 : 100,
                        child: Text(
                          court['id']?.toString() ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: isTablet ? 11 : 13),
                        ),
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        width: isTablet ? 120 : 150,
                        child: Text(
                          court['name']?.toString() ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: isTablet ? 11 : 13),
                        ),
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        width: isTablet ? 120 : 150,
                        child: Text(
                          court['location']?.toString() ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: isTablet ? 11 : 13),
                        ),
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        width: isTablet ? 80 : 100,
                        child: Text(
                          court['category']?.toString() ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: isTablet ? 11 : 13),
                        ),
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        width: isTablet ? 60 : 80,
                        child: Icon(
                          (court['isActive'] == true)
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: (court['isActive'] == true)
                              ? Colors.green
                              : Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        width: isTablet ? 60 : 80,
                        child: Icon(
                          (court['approved'] == true)
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: (court['approved'] == true)
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
                            onPressed: () async {
                              final docId = court['id'];
                              if (docId != null) {
                                // Optionally show a loading indicator or disable the button
                                await FirebaseFirestore.instance
                                    .collection('venues')
                                    .doc(docId)
                                    .update({'approved': true});
                              }
                            },
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
                              'Approve',
                              style: TextStyle(fontSize: isTablet ? 10 : 12),
                            ),
                          ),
                          SizedBox(width: isTablet ? 4 : 8),
                          ElevatedButton(
                            onPressed: () async {
                              final docId = court['id'];
                              if (docId != null) {
                                await FirebaseFirestore.instance
                                    .collection('venues')
                                    .doc(docId)
                                    .update({'approved': false});
                              }
                            },
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
                              'Denied',
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
      },
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
