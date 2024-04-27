// WImageProvider.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_app/datamodel/image_datamodel.dart';
import 'package:image_app/service/image_service.dart';

class WImageProvider extends ChangeNotifier {
  List images = [];
  Timer? _timer;




  void stopTimer() {
    _timer?.cancel();
  }

  getUser() async {
    try {
      ImageData fetchedImages = await fetchData();
      int index=0;
      images.add(fetchedImages.images[index]);
        _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      index++;
      images.add(fetchedImages.images[index]);
  
      notifyListeners();
    });

      notifyListeners();
    } catch (e) {
      print('Error fetching images: $e');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
