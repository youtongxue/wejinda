import 'package:wejinda/business/jww/jww_exam/dto/exam_req_dto.dart';
import 'package:wejinda/business/jww/jww_exam/dto/exam_time_req_dto.dart';
import 'package:wejinda/business/jww/jww_course/get_course_table_req_dto.dart';
import 'package:wejinda/business/jww/jww_login/dto/login_req_dto.dart';
import 'package:wejinda/business/jww/jww_score/dto/score_req_dto.dart';
import 'package:wejinda/business/jww/jww_score/dto/score_time_req_dto.dart';
import 'package:wejinda/utils/api_path_util.dart';

import '../../../utils/dio_util.dart';
import 'jww_api.dart';

class JwwApiImpl implements JwwApi {
  @override
  getCourseTable(GetCourseTableReqDTO getCourseTableReq) {
    return DioUtil.post(ApiPathUtil.getCourseTable, data: getCourseTableReq);
  }

  @override
  getExamInfo(ExamReqDTO examReq) {
    return DioUtil.post(ApiPathUtil.getExamInfo, data: examReq);
  }

  @override
  getExamTime(ExamTimeReqDTO examTimeReq) {
    return DioUtil.post(ApiPathUtil.getExamTime, data: examTimeReq);
  }

  @override
  getScoreInfo(ScoreReqDTO scoreReq) {
    return DioUtil.post(ApiPathUtil.getScoreInfo, data: scoreReq);
  }

  @override
  getScoreTime(ScoreTimeReqDTO scoreTimeReq) {
    return DioUtil.post(ApiPathUtil.getScoreTime, data: scoreTimeReq);
  }

  @override
  login(LoginReqDTO loginReq) {
    return DioUtil.post(ApiPathUtil.login, data: loginReq);
  }

  @override
  loginFirst() {
    return DioUtil.get(ApiPathUtil.loginFirst);
  }
}
