import 'package:wejinda/net/base/base_api.dart';
import 'package:wejinda/bean/to/jww/req/exam_req.dart';
import 'package:wejinda/bean/to/jww/req/exam_time_req.dart';
import 'package:wejinda/bean/to/jww/req/get_course_table_req.dart';
import 'package:wejinda/bean/to/jww/req/login_req.dart';
import 'package:wejinda/bean/to/jww/req/score_req.dart';
import 'package:wejinda/bean/to/jww/req/score_time_req.dart';
import 'package:wejinda/utils/api_path_util.dart';

import '../api/jww_api.dart';

class JwwApiImpl implements JwwApi {
  @override
  getCourseTable(GetCourseTableReq getCourseTableReq) {
    return BaseApiService.ableBaseUrlDio
        .post(ApiPathUtil.getCourseTable, data: getCourseTableReq);
  }

  @override
  getExamInfo(ExamReq examReq) {
    return BaseApiService.ableBaseUrlDio
        .post(ApiPathUtil.getExamInfo, data: examReq);
  }

  @override
  getExamTime(ExamTimeReq examTimeReq) {
    return BaseApiService.ableBaseUrlDio
        .post(ApiPathUtil.getExamTime, data: examTimeReq);
  }

  @override
  getScoreInfo(ScoreReq scoreReq) {
    return BaseApiService.ableBaseUrlDio
        .post(ApiPathUtil.getScoreInfo, data: scoreReq);
  }

  @override
  getScoreTime(ScoreTimeReq scoreTimeReq) {
    return BaseApiService.ableBaseUrlDio
        .post(ApiPathUtil.getScoreTime, data: scoreTimeReq);
  }

  @override
  login(LoginReq loginReq) {
    return BaseApiService.ableBaseUrlDio
        .post(ApiPathUtil.login, data: loginReq);
  }

  @override
  loginFirst() {
    return BaseApiService.ableBaseUrlDio.get(ApiPathUtil.loginFirst);
  }
}
