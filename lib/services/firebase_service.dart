import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Bookings
  Future<List<Map<String, dynamic>>> getBookings() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('bookings')
          .get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      print('Error fetching bookings: $e');
      return [];
    }
  }

  Future<void> updateBookingStatus(String bookingId, String status) async {
    try {
      await _firestore.collection('bookings').doc(bookingId).update({
        'status': status,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error updating booking status: $e');
      rethrow;
    }
  }

  Future<void> deleteBooking(String bookingId) async {
    try {
      await _firestore.collection('bookings').doc(bookingId).delete();
    } catch (e) {
      print('Error deleting booking: $e');
      rethrow;
    }
  }

  // Courts
  Future<List<Map<String, dynamic>>> getCourts() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('courts')
          .get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      print('Error fetching courts: $e');
      return [];
    }
  }

  Future<void> updateCourt(String courtId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('courts').doc(courtId).update({
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error updating court: $e');
      rethrow;
    }
  }

  Future<void> deleteCourt(String courtId) async {
    try {
      await _firestore.collection('courts').doc(courtId).delete();
    } catch (e) {
      print('Error deleting court: $e');
      rethrow;
    }
  }

  Future<void> approveCourt(String courtId) async {
    try {
      await _firestore.collection('courts').doc(courtId).update({
        'approved': true,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error approving court: $e');
      rethrow;
    }
  }

  // Users
  Future<List<Map<String, dynamic>>> getUsers() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('users').get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }

  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error updating user: $e');
      rethrow;
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
    } catch (e) {
      print('Error deleting user: $e');
      rethrow;
    }
  }

  // Real-time listeners
  Stream<List<Map<String, dynamic>>> getBookingsStream() {
    return _firestore.collection('bookings').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }

  Stream<List<Map<String, dynamic>>> getCourtsStream() {
    return _firestore.collection('courts').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }
}
