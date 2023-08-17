// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetailTransactionAdapter extends TypeAdapter<DetailTransaction> {
  @override
  final int typeId = 3;

  @override
  DetailTransaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DetailTransaction(
      product: fields[0] as Product,
      amount: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DetailTransaction obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.product)
      ..writeByte(1)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailTransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
