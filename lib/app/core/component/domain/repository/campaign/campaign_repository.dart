import 'package:crowd_funding/app/core/component/domain/models/request/upload_campaign_image_body.dart';
import 'package:crowd_funding/app/core/component/domain/models/response/campaign_detail_model.dart';
import 'package:crowd_funding/app/core/component/domain/models/response/campaign_list_model.dart';
import 'package:crowd_funding/app/core/component/domain/models/response/default_model.dart';
import 'package:crowd_funding/app/core/exception/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:crowd_funding/app/core/component/domain/models/request/create_campaign_body.dart';

abstract class CampaignRepository {
  Stream<Either<Failure, CampaignListModel>> getCampaignList();
  Stream<Either<Failure, CampaignListModel>> getCampaignListByUserId();
  Stream<Either<Failure, CampaignDetailModel>> campaignDetail(int id);
  Stream<Either<Failure, DefaultModel>> createCampaign(CreateCampaignBody body);
  Stream<Either<Failure, DefaultModel>> updateCampaign(
      CreateCampaignBody body, int id);
  Stream<Either<Failure, DefaultModel>> uploadCampaignImage(UploadCampaignImageBody body);

}
