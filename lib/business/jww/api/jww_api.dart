import '../jww_exam/dto/exam_req_dto.dart';
import '../jww_exam/dto/exam_time_req_dto.dart';
import '../jww_course/get_course_table_req_dto.dart';
import '../jww_login/dto/login_req_dto.dart';
import '../jww_score/dto/score_req_dto.dart';
import '../jww_score/dto/score_time_req_dto.dart';

abstract class JwwApi {
  // 登陆第一步
  dynamic loginFirst();

  // 登录
  dynamic login(LoginReqDTO loginReq);

  // 获取课表信息
  dynamic getCourseTable(GetCourseTableReqDTO getCourseTableReq);

  // 考试能够查询的学年
  dynamic getExamTime(ExamTimeReqDTO examTimeReq);

  // 查询考试安排详情
  dynamic getExamInfo(ExamReqDTO examReq);

  // 查询能够查询 考试成绩 的时间
  dynamic getScoreTime(ScoreTimeReqDTO scoreTimeReq);

  // 查询某学年考试成绩
  dynamic getScoreInfo(ScoreReqDTO scoreReq);
}
