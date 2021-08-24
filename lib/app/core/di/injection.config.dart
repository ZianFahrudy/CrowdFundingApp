// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../component/blocs/campaign/campaign_detail_bloc.dart' as _i19;
import '../component/blocs/campaign/campaign_list_bloc.dart' as _i20;
import '../component/blocs/campaign/create_campaign/create_campaign_bloc.dart'
    as _i11;
import '../component/blocs/campaign/update_campaign/update_campaign_bloc.dart'
    as _i16;
import '../component/blocs/campaign/upload_image/upload_image_campaign_bloc.dart'
    as _i18;
import '../component/blocs/login/login_bloc.dart' as _i13;
import '../component/blocs/transaction/checkout_bloc.dart' as _i10;
import '../component/blocs/transaction/transaction_list_bloc.dart' as _i15;
import '../component/blocs/user/get_userdata_bloc.dart' as _i12;
import '../component/blocs/user/register/register_bloc.dart' as _i14;
import '../component/blocs/user/upload_avatar/upload_avatar_bloc.dart' as _i17;
import '../component/domain/repository/campaign/campaign_repository.dart'
    as _i8;
import '../component/domain/repository/campaign/campaign_repository_impl.dart'
    as _i9;
import '../component/domain/repository/transaction/transaction_repository.dart'
    as _i4;
import '../component/domain/repository/transaction/transaction_repository_impl.dart'
    as _i5;
import '../component/domain/repository/user/user_repository.dart' as _i6;
import '../component/domain/repository/user/user_repository_impl.dart' as _i7;
import '../infrastructure/dio_module_injection.dart'
    as _i21; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final dioModuleInjectable = _$DioModuleInjectable();
  gh.lazySingleton<_i3.Dio>(() => dioModuleInjectable.dio);
  gh.lazySingleton<_i4.TransactionRepository>(
      () => _i5.TransactionRepositoryImpl(get<_i3.Dio>()));
  gh.lazySingleton<_i6.UserRepository>(
      () => _i7.UserRepositoryImpl(get<_i3.Dio>()));
  gh.lazySingleton<_i8.CampaignRepository>(
      () => _i9.CampaignRepositoryImpl(get<_i3.Dio>()));
  gh.factory<_i10.CheckoutBloc>(
      () => _i10.CheckoutBloc(get<_i4.TransactionRepository>()));
  gh.factory<_i11.CreateCampaignBloc>(
      () => _i11.CreateCampaignBloc(get<_i8.CampaignRepository>()));
  gh.factory<_i12.GetUserDataBloc>(
      () => _i12.GetUserDataBloc(get<_i6.UserRepository>()));
  gh.factory<_i13.LoginBloc>(() => _i13.LoginBloc(get<_i6.UserRepository>()));
  gh.factory<_i14.RegisterBloc>(
      () => _i14.RegisterBloc(get<_i6.UserRepository>()));
  gh.factory<_i15.TransactionListBloc>(
      () => _i15.TransactionListBloc(get<_i4.TransactionRepository>()));
  gh.factory<_i16.UpdateCampaignBloc>(
      () => _i16.UpdateCampaignBloc(get<_i8.CampaignRepository>()));
  gh.factory<_i17.UploadAvatarBloc>(
      () => _i17.UploadAvatarBloc(get<_i6.UserRepository>()));
  gh.factory<_i18.UploadImageCampaignBloc>(
      () => _i18.UploadImageCampaignBloc(get<_i8.CampaignRepository>()));
  gh.factory<_i19.CampaignDetailBloc>(
      () => _i19.CampaignDetailBloc(get<_i8.CampaignRepository>()));
  gh.factory<_i20.CampaignListBloc>(
      () => _i20.CampaignListBloc(get<_i8.CampaignRepository>()));
  gh.factory<_i20.CampaignListByIdBloc>(
      () => _i20.CampaignListByIdBloc(get<_i8.CampaignRepository>()));
  return get;
}

class _$DioModuleInjectable extends _i21.DioModuleInjectable {}
