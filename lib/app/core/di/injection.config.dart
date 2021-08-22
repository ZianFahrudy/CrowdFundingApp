// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../component/blocs/campaign/campaign_detail_bloc.dart' as _i9;
import '../component/blocs/campaign/campaign_list_bloc.dart' as _i10;
import '../component/blocs/login/login_bloc.dart' as _i8;
import '../component/domain/repository/campaign/campaign_repository.dart'
    as _i6;
import '../component/domain/repository/campaign/campaign_repository_impl.dart'
    as _i7;
import '../component/domain/repository/user/user_repository.dart' as _i4;
import '../component/domain/repository/user/user_repository_impl.dart' as _i5;
import '../infrastructure/dio_module_injection.dart'
    as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final dioModuleInjectable = _$DioModuleInjectable();
  gh.lazySingleton<_i3.Dio>(() => dioModuleInjectable.dio);
  gh.lazySingleton<_i4.UserRepository>(
      () => _i5.UserRepositoryImpl(get<_i3.Dio>()));
  gh.lazySingleton<_i6.CampaignRepository>(
      () => _i7.CampaignRepositoryImpl(get<_i3.Dio>()));
  gh.factory<_i8.LoginBloc>(() => _i8.LoginBloc(get<_i4.UserRepository>()));
  gh.factory<_i9.CampaignDetailBloc>(
      () => _i9.CampaignDetailBloc(get<_i6.CampaignRepository>()));
  gh.factory<_i10.CampaignListBloc>(
      () => _i10.CampaignListBloc(get<_i6.CampaignRepository>()));
  return get;
}

class _$DioModuleInjectable extends _i11.DioModuleInjectable {}
