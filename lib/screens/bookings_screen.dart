import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firebase_service.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1200;

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _firebaseService.getBookingsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text('Error: ${snapshot.error}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => setState(() {}),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final bookings = snapshot.data ?? [];

        if (bookings.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_today, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('No bookings found'),
              ],
            ),
          );
        }

        if (isMobile) {
          return _buildMobileView(bookings);
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: isTablet ? 16 : 24,
                columns: [
                  DataColumn(
                    label: Text(
                      'ID',
                      style: TextStyle(fontSize: isTablet ? 12 : 14),
                    ),
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
                        SizedBox(
                          width: isTablet ? 80 : 120,
                          child: SelectableText(
                            booking['id'] ?? '',
                            style: TextStyle(fontSize: isTablet ? 11 : 13),
                            maxLines: 1,
                            enableInteractiveSelection: true,
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: isTablet ? 80 : 120,
                          child: SelectableText(
                            booking['venueId'] ?? '',
                            style: TextStyle(fontSize: isTablet ? 11 : 13),
                            maxLines: 1,
                            enableInteractiveSelection: true,
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: isTablet ? 100 : 160,
                          child: SelectableText(
                            booking['userId'] ?? '',
                            style: TextStyle(fontSize: isTablet ? 11 : 13),
                            maxLines: 1,
                            enableInteractiveSelection: true,
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: isTablet ? 120 : 150,
                          child: SelectableText(
                            _formatDateTime(booking['startTime']),
                            style: TextStyle(fontSize: isTablet ? 11 : 13),
                            maxLines: 1,
                            enableInteractiveSelection: true,
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: isTablet ? 120 : 150,
                          child: SelectableText(
                            _formatDateTime(booking['endTime']),
                            style: TextStyle(fontSize: isTablet ? 11 : 13),
                            maxLines: 1,
                            enableInteractiveSelection: true,
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: isTablet ? 70 : 90,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(booking['status'] ?? ''),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: SelectableText(
                              booking['status'] ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              enableInteractiveSelection: true,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () => _confirmBooking(booking['id']),
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
                              onPressed: () => _cancelBooking(booking['id']),
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
          ),
        );
      },
    );
  }

  Widget _buildMobileView(List<Map<String, dynamic>> bookings) {
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
                        color: _getStatusColor(booking['status'] ?? ''),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        booking['status'] ?? '',
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
                Text('Start: ${_formatDateTime(booking['start'])}'),
                Text('End: ${_formatDateTime(booking['end'])}'),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _confirmBooking(booking['id']),
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
                        onPressed: () => _cancelBooking(booking['id']),
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

  String _formatDateTime(dynamic dateTime) {
    if (dateTime == null) return '';
    if (dateTime is Timestamp) {
      final date = dateTime.toDate();
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}.000';
    }
    return dateTime.toString();
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

  Future<void> _confirmBooking(String? bookingId) async {
    if (bookingId == null) return;

    try {
      await _firebaseService.updateBookingStatus(bookingId, 'confirmed');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking confirmed successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error confirming booking: $e')));
    }
  }

  Future<void> _cancelBooking(String? bookingId) async {
    if (bookingId == null) return;

    try {
      await _firebaseService.updateBookingStatus(bookingId, 'cancelled');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking cancelled successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error cancelling booking: $e')));
    }
  }
}
