import 'package:flutter/material.dart';
import 'package:uplatform/models/request_model.dart';

import 'network.dart';

class ServiceList {
  static final ServiceList _singleton = ServiceList._internal();

  factory ServiceList() {
    return _singleton;
  }

  ServiceList._internal() {
    debugPrint('ServiceList(Singleton) was created.');
    loadServiceList();
  }

  List<ServiceItem> _serviceItemList = [];

  void loadItems() {
    debugPrint('loadItems() - serviceList load Items');
  }

  Future loadServiceList() async {
    if (_serviceItemList.isNotEmpty) {
      debugPrint('loadServiceList() already loaded');
      return;
    }

    debugPrint('loadServiceList() start');

    Map<String, dynamic> params = {};

    params['service_type'] = "위생정리서비스";
    List<ServiceItem>? serviceItemList = await Network().reqServiceList(params);

    if (serviceItemList != null) {
      _serviceItemList = serviceItemList;
    }

    params['service_type'] = "공간정리서비스";
    serviceItemList = await Network().reqServiceList(params);

    if (serviceItemList != null) {
      _serviceItemList.addAll(serviceItemList);
    }

    params['service_type'] = "정리교육서비스";
    serviceItemList = await Network().reqServiceList(params);

    if (serviceItemList != null) {
      _serviceItemList.addAll(serviceItemList);
    }

    debugPrint('loadServiceList() finish');
  }

  ServiceItem? getServiceItem(String serviceId) {
    debugPrint('getServiceItem() serviceId $serviceId');
    if (serviceId.isEmpty) {
      return null;
    }

    if (_serviceItemList.isEmpty) {
      return null;
    }

    for (int i = 0; i < _serviceItemList.length; i++) {
      if ((_serviceItemList[i].id) == serviceId.trim()) {
        return _serviceItemList[i];
      }
    }

    return null;
  }
}