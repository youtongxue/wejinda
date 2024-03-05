import '../../bean/to/jww/req/exam_req.dart';
import '../../bean/to/jww/req/exam_time_req.dart';
import '../../bean/to/jww/req/get_course_table_req.dart';
import '../../bean/to/jww/req/login_req.dart';
import '../../bean/to/jww/req/score_req.dart';
import '../../bean/to/jww/req/score_time_req.dart';

abstract class JwwApi {
  // 登陆第一步
  dynamic loginFirst();

  // 登录
  dynamic login(LoginReq loginReq);

  // 获取课表信息
  dynamic getCourseTable(GetCourseTableReq getCourseTableReq);

  // 考试能够查询的学年
  dynamic getExamTime(ExamTimeReq examTimeReq);

  // 查询考试安排详情
  dynamic getExamInfo(ExamReq examReq);

  // 查询能够查询 考试成绩 的时间
  dynamic getScoreTime(ScoreTimeReq scoreTimeReq);

  // 查询某学年考试成绩
  dynamic getScoreInfo(ScoreReq scoreReq);
}
