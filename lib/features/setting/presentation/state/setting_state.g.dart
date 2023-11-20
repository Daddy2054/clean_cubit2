// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingStateImpl _$$SettingStateImplFromJson(Map<String, dynamic> json) =>
    _$SettingStateImpl(
      appTheme: $enumDecodeNullable(_$AppThemeEnumMap, json['appTheme']) ??
          AppTheme.light,
    );

Map<String, dynamic> _$$SettingStateImplToJson(_$SettingStateImpl instance) =>
    <String, dynamic>{
      'appTheme': _$AppThemeEnumMap[instance.appTheme]!,
    };

const _$AppThemeEnumMap = {
  AppTheme.light: 'light',
  AppTheme.dark: 'dark',
};
