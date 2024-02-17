// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_param_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppParamState {
  String get selectedBunrui => throw _privateConstructorUsedError;
  List<String> get youtubeIdList => throw _privateConstructorUsedError;
  String get selectedYear => throw _privateConstructorUsedError;
  String get searchText => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppParamStateCopyWith<AppParamState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppParamStateCopyWith<$Res> {
  factory $AppParamStateCopyWith(
          AppParamState value, $Res Function(AppParamState) then) =
      _$AppParamStateCopyWithImpl<$Res, AppParamState>;
  @useResult
  $Res call(
      {String selectedBunrui,
      List<String> youtubeIdList,
      String selectedYear,
      String searchText});
}

/// @nodoc
class _$AppParamStateCopyWithImpl<$Res, $Val extends AppParamState>
    implements $AppParamStateCopyWith<$Res> {
  _$AppParamStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedBunrui = null,
    Object? youtubeIdList = null,
    Object? selectedYear = null,
    Object? searchText = null,
  }) {
    return _then(_value.copyWith(
      selectedBunrui: null == selectedBunrui
          ? _value.selectedBunrui
          : selectedBunrui // ignore: cast_nullable_to_non_nullable
              as String,
      youtubeIdList: null == youtubeIdList
          ? _value.youtubeIdList
          : youtubeIdList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      selectedYear: null == selectedYear
          ? _value.selectedYear
          : selectedYear // ignore: cast_nullable_to_non_nullable
              as String,
      searchText: null == searchText
          ? _value.searchText
          : searchText // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppParamStateCopyWith<$Res>
    implements $AppParamStateCopyWith<$Res> {
  factory _$$_AppParamStateCopyWith(
          _$_AppParamState value, $Res Function(_$_AppParamState) then) =
      __$$_AppParamStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String selectedBunrui,
      List<String> youtubeIdList,
      String selectedYear,
      String searchText});
}

/// @nodoc
class __$$_AppParamStateCopyWithImpl<$Res>
    extends _$AppParamStateCopyWithImpl<$Res, _$_AppParamState>
    implements _$$_AppParamStateCopyWith<$Res> {
  __$$_AppParamStateCopyWithImpl(
      _$_AppParamState _value, $Res Function(_$_AppParamState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedBunrui = null,
    Object? youtubeIdList = null,
    Object? selectedYear = null,
    Object? searchText = null,
  }) {
    return _then(_$_AppParamState(
      selectedBunrui: null == selectedBunrui
          ? _value.selectedBunrui
          : selectedBunrui // ignore: cast_nullable_to_non_nullable
              as String,
      youtubeIdList: null == youtubeIdList
          ? _value._youtubeIdList
          : youtubeIdList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      selectedYear: null == selectedYear
          ? _value.selectedYear
          : selectedYear // ignore: cast_nullable_to_non_nullable
              as String,
      searchText: null == searchText
          ? _value.searchText
          : searchText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_AppParamState implements _AppParamState {
  const _$_AppParamState(
      {required this.selectedBunrui,
      required final List<String> youtubeIdList,
      required this.selectedYear,
      required this.searchText})
      : _youtubeIdList = youtubeIdList;

  @override
  final String selectedBunrui;
  final List<String> _youtubeIdList;
  @override
  List<String> get youtubeIdList {
    if (_youtubeIdList is EqualUnmodifiableListView) return _youtubeIdList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_youtubeIdList);
  }

  @override
  final String selectedYear;
  @override
  final String searchText;

  @override
  String toString() {
    return 'AppParamState(selectedBunrui: $selectedBunrui, youtubeIdList: $youtubeIdList, selectedYear: $selectedYear, searchText: $searchText)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppParamState &&
            (identical(other.selectedBunrui, selectedBunrui) ||
                other.selectedBunrui == selectedBunrui) &&
            const DeepCollectionEquality()
                .equals(other._youtubeIdList, _youtubeIdList) &&
            (identical(other.selectedYear, selectedYear) ||
                other.selectedYear == selectedYear) &&
            (identical(other.searchText, searchText) ||
                other.searchText == searchText));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      selectedBunrui,
      const DeepCollectionEquality().hash(_youtubeIdList),
      selectedYear,
      searchText);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppParamStateCopyWith<_$_AppParamState> get copyWith =>
      __$$_AppParamStateCopyWithImpl<_$_AppParamState>(this, _$identity);
}

abstract class _AppParamState implements AppParamState {
  const factory _AppParamState(
      {required final String selectedBunrui,
      required final List<String> youtubeIdList,
      required final String selectedYear,
      required final String searchText}) = _$_AppParamState;

  @override
  String get selectedBunrui;
  @override
  List<String> get youtubeIdList;
  @override
  String get selectedYear;
  @override
  String get searchText;
  @override
  @JsonKey(ignore: true)
  _$$_AppParamStateCopyWith<_$_AppParamState> get copyWith =>
      throw _privateConstructorUsedError;
}
