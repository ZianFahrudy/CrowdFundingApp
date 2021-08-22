import 'package:crowd_funding/app/core/component/domain/models/response/campaign_detail_model.dart';
import 'package:crowd_funding/app/core/component/domain/models/response/campaign_list_model.dart';
import 'package:crowd_funding/app/core/component/domain/repository/campaign/campaign_repository.dart';
import 'package:crowd_funding/app/core/constants/apipath.dart';
import 'package:crowd_funding/app/core/exception/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CampaignRepository)
class CampaignRepositoryImpl implements CampaignRepository {
  Dio _dio;
  CampaignRepositoryImpl(this._dio);
  @override
  Stream<Either<Failure, CampaignListModel>> getCampaignList() async* {
    Response response;
    try {
      response = await _dio.get(ApiPath.campaign);
      var data = CampaignListModel.fromJson(response.data);
      print("RESPONSE => ${response.data}");
      yield right(data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        var errorData = e.response!.data['meta']['message'];
        var errorResult = Failure(errorData);
        yield left(errorResult);
      }
      yield left(Failure("Something error bro"));
    } catch (e) {
      yield left(Failure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, CampaignDetailModel>> campaignDetail(int id) async* {
    Response response;
    try {
      response = await _dio.get("${ApiPath.campaign}/$id");
      var data = CampaignDetailModel.fromJson(response.data);
      print("RESPONSE => ${response.data}");
      yield right(data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        var errorData = e.response!.data['meta']['message'];
        var errorResult = Failure(errorData);
        yield left(errorResult);
      }
      yield left(Failure("Something error bro"));
    } catch (e) {
      yield left(Failure(e.toString()));
    }
  }
}
