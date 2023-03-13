import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wejinda/controller/course/timetableController.dart';
import 'package:wejinda/enum/PrefersEnum.dart';

class PrefesService extends GetxService {
  late final SharedPreferences prefers;

  Future<PrefesService> init() async {
    prefers = await SharedPreferences.getInstance();
    return this;
  }

  /*
   * 写入数据 
   */
  insertStringPrefes(String key, String value) async {
    await prefers.setString(key, value);
    print("数据 ${key + value} 写入prefers完成✅");
  }

  insetIntPrefes(String key, int value) async {
    await prefers.setInt(key, value);
    print("数据 ${key + value.toString()} 写入prefers完成✅");
  }

  /*
   * 删除数据 
   */
  removePrefes(String key) async {
    await prefers.remove(key);
    print("清除 prefes 中 $key 完成✅");
  }

  @override
  void onReady() {
    super.onReady();

    print("SharedPreferences 异步初始化完成✅");

    /**
     * 更新 TimeTableController 中的数据
     * CourseData -> 课表数据
     * WeekDay -> 是否显示周末
     */
    final timeTableController = Get.find<TimeTableController>();

    // 加载SharedPerfence中课表数据
    timeTableController.courseData.value =
        prefers.getString(PrefersEnum.courseData.key) ?? '';
    // 设置是否显示周末课程
    timeTableController.weekDay.value =
        prefers.getInt(PrefersEnum.weekDay.key) ?? 5;

    timeTableController.prefesService = this;
    print("课表数据从 prefers 加载完成✅");
  }
}
