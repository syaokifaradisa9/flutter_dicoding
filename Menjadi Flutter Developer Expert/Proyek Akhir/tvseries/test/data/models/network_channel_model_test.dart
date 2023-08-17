import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/data/models/network_channel_model.dart';
import 'package:tvseries/domain/entities/network_channel.dart';

void main() {
  const tNetworkChannelModel = NetworkChannelModel(
    name: 'name',
    id: 1,
    country: 'country',
    logoPath: 'logoPath'
  );

  const tNetworkChannel = NetworkChannel(
    name: 'name',
    id: 1,
    country: 'country',
    logoPath: 'logoPath'
  );

  const tNetworkChannelAnother1 = NetworkChannel(
      name: 'name',
      id: 1,
      country: 'country',
      logoPath: 'logoPath'
  );

  const tNetworkChannelAnother2 = NetworkChannel(
      name: 'name',
      id: 2,
      country: 'country',
      logoPath: 'logoPath'
  );

  Map<String, dynamic> jsonMap = {
    'id': 1,
    'name': 'name',
    'logo_path': 'logoPath',
    'origin_country': 'country',
  };

  test('should be a subclass of NetworkChannel entity', () async {
    final result = tNetworkChannelModel.toEntity();
    expect(result, tNetworkChannel);
  });

  test('should return a valid NetworkChannelModel instance from JSON', () {
    final result = NetworkChannelModel.fromJson(jsonMap);
    expect(result, tNetworkChannelModel);
  });

  test('should return a JSON map containing proper data', () {
    final result = tNetworkChannelModel.toJson();
    expect(result, jsonMap);
  });

  test('should return true when props are equal', () {
    expect(tNetworkChannel.props, tNetworkChannelAnother1.props);
  });

  test('should return false when props are not equal', () {
    expect(tNetworkChannel.props, isNot(tNetworkChannelAnother2.props));
  });
}
