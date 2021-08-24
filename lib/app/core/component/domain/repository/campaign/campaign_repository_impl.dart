import 'package:crowd_funding/app/core/component/domain/models/request/create_campaign_body.dart';
import 'package:crowd_funding/app/core/component/domain/models/request/upload_campaign_image_body.dart';
import 'package:crowd_funding/app/core/component/domain/models/response/campaign_detail_model.dart';
import 'package:crowd_funding/app/core/component/domain/models/response/campaign_list_model.dart';
import 'package:crowd_funding/app/core/component/domain/models/response/default_model.dart';
import 'package:crowd_funding/app/core/component/domain/repository/campaign/campaign_repository.dart';
import 'package:crowd_funding/app/core/constants/apipath.dart';
import 'package:crowd_funding/app/core/constants/keycontant.dart';
import 'package:crowd_funding/app/core/exception/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CampaignRepository)
class CampaignRepositoryImpl implements CampaignRepository {
  Dio _dio;
  CampaignRepositoryImpl(this._dio);

  final storage = GetStorage();
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

  @override
  Stream<Either<Failure, CampaignListModel>> getCampaignListByUserId() async* {
    Response response;
    try {
      response = await _dio.get(
          "${ApiPath.campaign}?user_id=${storage.read(KeyConstant.userId)}");
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
  Stream<Either<Failure, DefaultModel>> createCampaign(
      CreateCampaignBody body) async* {
    Response response;
    try {
      response = await _dio.post(ApiPath.campaign,
          data: body.toJson(),
          options: Options(headers: {
            'Authorization': 'Bearer ${storage.read(KeyConstant.token)}'
          }));
      var data = DefaultModel.fromJson(response.data);
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
  Stream<Either<Failure, DefaultModel>> updateCampaign(
      CreateCampaignBody body, int id) async* {
    Response response;
    try {
      response = await _dio.put("${ApiPath.campaign}/$id",
          data: body.toJson(),
          options: Options(headers: {
            'Authorization': 'Bearer ${storage.read(KeyConstant.token)}'
          }));
      var data = DefaultModel.fromJson(response.data);
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
  Stream<Either<Failure, DefaultModel>> uploadCampaignImage(
      UploadCampaignImageBody body) async* {
    Response response;
    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(body.file!),
        'campaign_id': body.campaignId,
        'is_primary': body.isPrimary
      });
      response = await _dio.post(ApiPath.campaignImages,
          data: formData,
          options: Options(headers: {
            "Authorization": "Bearer ${storage.read(KeyConstant.token)}",
            "Content-Type": "multipart/form-data"
          }));
      var data = DefaultModel.fromJson(response.data);
      yield right(data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        var errorData = e.response!.data['meta']['message'];
        var errorResult = Failure(errorData);

        yield left(errorResult);
      }
      yield left(Failure("Something error"));
    } catch (e) {
      yield left(Failure(e.toString()));
    }
  }
}
