// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreHelperProvider = Provider<FirestoreHelper>(
    (ref) => FirestoreHelper(FirebaseFirestore.instance));

class FirestoreHelper {
  const FirestoreHelper(this.db);
  final FirebaseFirestore db;

  Future<void> addDoC({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final ref = db.collection(path);
    debugPrint('$path: $data');
    await ref.add(data);
  }

  Future<void> updateDoc({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final ref = db.doc(path);
    debugPrint('$path: $data');
    await ref.update(data);
  }

  Future<void> deleteDoc({
    required String path,
  }) async {
    final ref = db.doc(path);
    debugPrint('delete: $path');
    await ref.delete();
  }

  Future<void> setField({
    required String path,
    required Map<String, dynamic> fieldData,
    bool merge = true,
  }) async {
    final ref = db.doc(path);
    debugPrint('$path: $fieldData');
    await ref.set(fieldData, SetOptions(merge: merge));
  }

  Future<void> deleteField({
    required String path,
    required String field,
  }) async {
    final ref = db.doc(path);
    debugPrint('delete: $path');
    await ref.update({field: FieldValue.delete()});
  }

  Future<void> removeArrayElements({
    required String path,
    required String field,
    required List<dynamic> targetElements,
  }) async {
    final ref = db.doc(path);
    await ref.update({field: FieldValue.arrayRemove(targetElements)});
    debugPrint('arrayRemove: $path of $field field');
  }

  Query query({
    required String path,
    Query Function(Query query)? queryBuilder,
  }) {
    Query query = db.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    return query;
  }

  Stream<List<T>> getStreamDocs<T>({
    required String path,
    required T Function(Object? data, String documentID) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = db.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) => builder(snapshot.data(), snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Stream<T> getStreamDoc<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentID) builder,
  }) {
    final ref = db.doc(path);
    final snapshots = ref.snapshots();
    return snapshots.map((snapshot) => builder(snapshot.data(), snapshot.id));
  }

  Future<T> getFutureDoc<T>({
    required String path,
  }) async {
    final ref = db.doc(path);
    final doc = await ref.get();
    return doc.data() as T;
  }

  Future<List<T>> getFutureDocs<T>({
    required String path,
    required T Function(Object? data, String documentID) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) async {
    Query query = db.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final qs = await query.get();
    final result = qs.docs
        .map((qsnap) => builder(qsnap.data(), qsnap.id))
        .where((value) => value != null)
        .toList();
    if (sort != null) {
      result.sort(sort);
    }
    return result;
  }

  Future<void> setMultipleData({
    required String path,
    required List<Map<String, dynamic>> dataList,
    required String documentIdName,
  }) async {
    final batch = db.batch();
    for (var data in dataList) {
      final documentId = data[documentIdName] as String;
      batch.set(
        db.collection(path).doc(documentId),
        data,
        SetOptions(merge: true),
      );
    }
    await batch.commit();
  }
}
