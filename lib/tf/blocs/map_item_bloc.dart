import 'dart:async';

import 'package:theforest/tf/data/api_response.dart';
import 'package:theforest/tf/models/map_item.dart';
import 'package:theforest/tf/repositories/map_item_repository.dart';

class MapItemBloc {
  MapItemRepository _repository;
  StreamController _controller;

  MapItemBloc() {
    _repository = MapItemRepository();
    _controller = StreamController<List<List<MapItemModel>>>();
    fetchMapItems();
  }

//TODO add types to streams
  StreamSink get sink => _controller.sink;
  Stream<List<List<MapItemModel>>> get stream => _controller.stream;

  fetchMapItems() async {
    try {
      sink.add([
        await _repository.fetchCaves,
        await _repository.fetchGear,
        await _repository.fetchCollectables,
      ]);
    } catch (e) {
      print("SINK ERROR");
      sink.addError(e);
    }
  }

  dispose() {
    _controller?.close();
    print("Disposed");
  }
}