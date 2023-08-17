import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/helper/datetime_helper.dart';
import 'package:restaurant_app/services/schedule_service.dart';
import 'package:restaurant_app/services/setting_service.dart';

class SchedulingProvider with ChangeNotifier{
  late final SettingService _settingService;
  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  SchedulingProvider({ required SettingService settingService}){
    _settingService = settingService;
    initializationStatus();
  }

  void initializationStatus() async{
    _isScheduled = await _settingService.getScheduleStatus();
    notifyListeners();
  }

  Future<bool> setScheduledStatus(bool value) async{
    _isScheduled = await _settingService.setStatusSchedule(value);
    notifyListeners();
    if(_isScheduled){
      return await AndroidAlarmManager.periodic(
          const Duration(hours: 24),
          1,
          ScheduleService.callback,
          startAt: DateTimeHelper.format(),
          exact: true,
          wakeup: true,
      );
    }else{
      return await AndroidAlarmManager.cancel(1);
    }
  }
}