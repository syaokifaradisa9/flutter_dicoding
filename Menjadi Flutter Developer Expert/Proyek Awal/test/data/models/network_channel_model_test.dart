import 'package:ditonton/data/models/network_channel_model.dart';
import 'package:ditonton/domain/entities/network_channel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tNetworkChannelModel = NetworkChannelModel(
    name: 'name',
    id: 1,
    country: 'country',
    logoPath: 'logoPath'
  );

  final tNetworkChannel = NetworkChannel(
    name: 'name',
    id: 1,
    country: 'country',
    logoPath: 'logoPath'
  );

  test('should be a subclass of NetworkChannel entity', () async {
    final result = tNetworkChannelModel.toEntity();
    expect(result, tNetworkChannel);
  });
}
