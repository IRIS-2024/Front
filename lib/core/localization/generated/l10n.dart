// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class I10n {
  I10n();

  static I10n? _current;

  static I10n get current {
    assert(_current != null,
        'No instance of I10n was loaded. Try to initialize the I10n delegate before accessing I10n.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<I10n> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = I10n();
      I10n._current = instance;

      return instance;
    });
  }

  static I10n of(BuildContext context) {
    final instance = I10n.maybeOf(context);
    assert(instance != null,
        'No instance of I10n present in the widget tree. Did you add I10n.delegate in localizationsDelegates?');
    return instance!;
  }

  static I10n? maybeOf(BuildContext context) {
    return Localizations.of<I10n>(context, I10n);
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `View Details`
  String get view {
    return Intl.message(
      'View Details',
      name: 'view',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Sign in/Sign up`
  String get login {
    return Intl.message(
      'Sign in/Sign up',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Login with Google`
  String get googleLogin {
    return Intl.message(
      'Login with Google',
      name: 'googleLogin',
      desc: '',
      args: [],
    );
  }

  /// `Current Location`
  String get currentLocation {
    return Intl.message(
      'Current Location',
      name: 'currentLocation',
      desc: '',
      args: [],
    );
  }

  /// `Missing Persons`
  String get main {
    return Intl.message(
      'Missing Persons',
      name: 'main',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get report {
    return Intl.message(
      'Report',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  /// `Latest Reports`
  String get post {
    return Intl.message(
      'Latest Reports',
      name: 'post',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get map {
    return Intl.message(
      'Map',
      name: 'map',
      desc: '',
      args: [],
    );
  }

  /// `Location Update`
  String get updateLocation {
    return Intl.message(
      'Location Update',
      name: 'updateLocation',
      desc: '',
      args: [],
    );
  }

  /// `Successfully updated current location.`
  String get updateLocationAlert {
    return Intl.message(
      'Successfully updated current location.',
      name: 'updateLocationAlert',
      desc: '',
      args: [],
    );
  }

  /// `No submitted missing reports found.`
  String get emptyInfo {
    return Intl.message(
      'No submitted missing reports found.',
      name: 'emptyInfo',
      desc: '',
      args: [],
    );
  }

  /// `y.o.`
  String get ageunit {
    return Intl.message(
      'y.o.',
      name: 'ageunit',
      desc: '',
      args: [],
    );
  }

  /// `Refresh search at this location.`
  String get refreshMap {
    return Intl.message(
      'Refresh search at this location.',
      name: 'refreshMap',
      desc: '',
      args: [],
    );
  }

  /// `Missing Person Reports`
  String get missingPost {
    return Intl.message(
      'Missing Person Reports',
      name: 'missingPost',
      desc: '',
      args: [],
    );
  }

  /// `Detail`
  String get detail {
    return Intl.message(
      'Detail',
      name: 'detail',
      desc: '',
      args: [],
    );
  }

  /// `Witness Comment`
  String get comment {
    return Intl.message(
      'Witness Comment',
      name: 'comment',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Report`
  String get cancelReport {
    return Intl.message(
      'Cancel Report',
      name: 'cancelReport',
      desc: '',
      args: [],
    );
  }

  /// `Submit a Comment`
  String get submitTip {
    return Intl.message(
      'Submit a Comment',
      name: 'submitTip',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get ageMissing {
    return Intl.message(
      'Age',
      name: 'ageMissing',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get height {
    return Intl.message(
      'Height',
      name: 'height',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get weight {
    return Intl.message(
      'Weight',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `Missing Location`
  String get missingLocation {
    return Intl.message(
      'Missing Location',
      name: 'missingLocation',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get missingLocationShort {
    return Intl.message(
      'Location',
      name: 'missingLocationShort',
      desc: '',
      args: [],
    );
  }

  /// `Clothing Description`
  String get missingDescription {
    return Intl.message(
      'Clothing Description',
      name: 'missingDescription',
      desc: '',
      args: [],
    );
  }

  /// `Identifying Characteristics`
  String get characteristics {
    return Intl.message(
      'Identifying Characteristics',
      name: 'characteristics',
      desc: '',
      args: [],
    );
  }

  /// `Characteristics`
  String get characteristicsShort {
    return Intl.message(
      'Characteristics',
      name: 'characteristicsShort',
      desc: '',
      args: [],
    );
  }

  /// `just a moment ago`
  String get momentAgo {
    return Intl.message(
      'just a moment ago',
      name: 'momentAgo',
      desc: '',
      args: [],
    );
  }

  /// ` minutes ago`
  String get minutesAgo {
    return Intl.message(
      ' minutes ago',
      name: 'minutesAgo',
      desc: '',
      args: [],
    );
  }

  /// ` hours ago`
  String get hoursAgo {
    return Intl.message(
      ' hours ago',
      name: 'hoursAgo',
      desc: '',
      args: [],
    );
  }

  /// `Matching rate of {rate}% or higher`
  String matchingRateFilter(Object rate) {
    return Intl.message(
      'Matching rate of $rate% or higher',
      name: 'matchingRateFilter',
      desc: '',
      args: [rate],
    );
  }

  /// `No matching witness comments found.`
  String get noCommt {
    return Intl.message(
      'No matching witness comments found.',
      name: 'noCommt',
      desc: '',
      args: [],
    );
  }

  /// `No witness comments have been submitted yet.`
  String get emptyCommt {
    return Intl.message(
      'No witness comments have been submitted yet.',
      name: 'emptyCommt',
      desc: '',
      args: [],
    );
  }

  /// `Matching rate\n{rate2}%`
  String matchingRate(Object rate2) {
    return Intl.message(
      'Matching rate\n$rate2%',
      name: 'matchingRate',
      desc: '',
      args: [rate2],
    );
  }

  /// `Circumstances`
  String get circumstances {
    return Intl.message(
      'Circumstances',
      name: 'circumstances',
      desc: '',
      args: [],
    );
  }

  /// `Report Missing Person`
  String get reportMissingTitle {
    return Intl.message(
      'Report Missing Person',
      name: 'reportMissingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Missing Person`
  String get postMissingPerson {
    return Intl.message(
      'Missing Person',
      name: 'postMissingPerson',
      desc: '',
      args: [],
    );
  }

  /// `Missing Person's Name`
  String get postMissingName {
    return Intl.message(
      'Missing Person\'s Name',
      name: 'postMissingName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a name.`
  String get postName {
    return Intl.message(
      'Please enter a name.',
      name: 'postName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the missing person's name.`
  String get postHintName {
    return Intl.message(
      'Please enter the missing person\'s name.',
      name: 'postHintName',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `F`
  String get f {
    return Intl.message(
      'F',
      name: 'f',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `M`
  String get m {
    return Intl.message(
      'M',
      name: 'm',
      desc: '',
      args: [],
    );
  }

  /// `Time of Disappearance`
  String get missingTime {
    return Intl.message(
      'Time of Disappearance',
      name: 'missingTime',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get missingTimeShort {
    return Intl.message(
      'Time',
      name: 'missingTimeShort',
      desc: '',
      args: [],
    );
  }

  /// `Clothing`
  String get clothing {
    return Intl.message(
      'Clothing',
      name: 'clothing',
      desc: '',
      args: [],
    );
  }

  /// `Description of Clothing`
  String get postClothing {
    return Intl.message(
      'Description of Clothing',
      name: 'postClothing',
      desc: '',
      args: [],
    );
  }

  /// `Please describe clothing type and color. (e.g. yellow sweater, black pants)`
  String get postHintClothing {
    return Intl.message(
      'Please describe clothing type and color. (e.g. yellow sweater, black pants)',
      name: 'postHintClothing',
      desc: '',
      args: [],
    );
  }

  /// `Please provide details such as the missing person's physique, facial features, distinctive behaviors, medical conditions, and detailed clothing description.`
  String get postHintCharact {
    return Intl.message(
      'Please provide details such as the missing person\'s physique, facial features, distinctive behaviors, medical conditions, and detailed clothing description.',
      name: 'postHintCharact',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the age in years.`
  String get postAge {
    return Intl.message(
      'Please enter the age in years.',
      name: 'postAge',
      desc: '',
      args: [],
    );
  }

  /// `Enter Time`
  String get enterTime {
    return Intl.message(
      'Enter Time',
      name: 'enterTime',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the time.`
  String get enterTimePlz {
    return Intl.message(
      'Please enter the time.',
      name: 'enterTimePlz',
      desc: '',
      args: [],
    );
  }

  /// `Enter Location`
  String get enterLocation {
    return Intl.message(
      'Enter Location',
      name: 'enterLocation',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the location.`
  String get enterLocationPlz {
    return Intl.message(
      'Please enter the location.',
      name: 'enterLocationPlz',
      desc: '',
      args: [],
    );
  }

  /// `Select Location`
  String get pickLocation {
    return Intl.message(
      'Select Location',
      name: 'pickLocation',
      desc: '',
      args: [],
    );
  }

  /// `Please select a location.`
  String get pickLocationPlz {
    return Intl.message(
      'Please select a location.',
      name: 'pickLocationPlz',
      desc: '',
      args: [],
    );
  }

  /// `To enter this location, please press the button.`
  String get checkLocation {
    return Intl.message(
      'To enter this location, please press the button.',
      name: 'checkLocation',
      desc: '',
      args: [],
    );
  }

  /// `(Up to 3 photos.)`
  String get maxPhoto {
    return Intl.message(
      '(Up to 3 photos.)',
      name: 'maxPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Please add a photo.`
  String get addPhoto {
    return Intl.message(
      'Please add a photo.',
      name: 'addPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Add More`
  String get add {
    return Intl.message(
      'Add More',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `This is an image generated by AI\nbased on the entered information.`
  String get aiImg {
    return Intl.message(
      'This is an image generated by AI\nbased on the entered information.',
      name: 'aiImg',
      desc: '',
      args: [],
    );
  }

  /// `Generating AI image based on missing person information.`
  String get processAI {
    return Intl.message(
      'Generating AI image based on missing person information.',
      name: 'processAI',
      desc: '',
      args: [],
    );
  }

  /// `Would you like to use the generated AI image\n as the representative image?`
  String get askAI {
    return Intl.message(
      'Would you like to use the generated AI image\n as the representative image?',
      name: 'askAI',
      desc: '',
      args: [],
    );
  }

  /// `Use as Thumbnail image.`
  String get useAI {
    return Intl.message(
      'Use as Thumbnail image.',
      name: 'useAI',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get addAI {
    return Intl.message(
      'Register',
      name: 'addAI',
      desc: '',
      args: [],
    );
  }

  /// `When`
  String get commentTime {
    return Intl.message(
      'When',
      name: 'commentTime',
      desc: '',
      args: [],
    );
  }

  /// `Where`
  String get commentLocation {
    return Intl.message(
      'Where',
      name: 'commentLocation',
      desc: '',
      args: [],
    );
  }

  /// `Description of Clothing`
  String get commentClothing {
    return Intl.message(
      'Description of Clothing',
      name: 'commentClothing',
      desc: '',
      args: [],
    );
  }

  /// `Please describe the clothing worn at the time of sighting, including the style, color, and accessories.`
  String get commentClothingHint {
    return Intl.message(
      'Please describe the clothing worn at the time of sighting, including the style, color, and accessories.',
      name: 'commentClothingHint',
      desc: '',
      args: [],
    );
  }

  /// `Circumstances`
  String get commentCircumstances {
    return Intl.message(
      'Circumstances',
      name: 'commentCircumstances',
      desc: '',
      args: [],
    );
  }

  /// `Please describe the circumstances, behavior, and situation of the missing person.`
  String get commentCircumstancesHint {
    return Intl.message(
      'Please describe the circumstances, behavior, and situation of the missing person.',
      name: 'commentCircumstancesHint',
      desc: '',
      args: [],
    );
  }

  /// `Determining the matching rate of the reported photo.`
  String get processMatchingRate {
    return Intl.message(
      'Determining the matching rate of the reported photo.',
      name: 'processMatchingRate',
      desc: '',
      args: [],
    );
  }

  /// `Once the matching rate determination is complete,\nthe witness comment will be submitted.`
  String get indicatorMatchingRate {
    return Intl.message(
      'Once the matching rate determination is complete,\nthe witness comment will be submitted.',
      name: 'indicatorMatchingRate',
      desc: '',
      args: [],
    );
  }

  /// `Notification Settings`
  String get pushSettings {
    return Intl.message(
      'Notification Settings',
      name: 'pushSettings',
      desc: '',
      args: [],
    );
  }

  /// `Report Missing Person`
  String get addMissingPost {
    return Intl.message(
      'Report Missing Person',
      name: 'addMissingPost',
      desc: '',
      args: [],
    );
  }

  /// `New Missing Report in Area of Interest`
  String get newMissingPost {
    return Intl.message(
      'New Missing Report in Area of Interest',
      name: 'newMissingPost',
      desc: '',
      args: [],
    );
  }

  /// `Select Area of Interest`
  String get selectInterest {
    return Intl.message(
      'Select Area of Interest',
      name: 'selectInterest',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get firstArea {
    return Intl.message(
      'City',
      name: 'firstArea',
      desc: '',
      args: [],
    );
  }

  /// `State/Province/Region`
  String get secondArea {
    return Intl.message(
      'State/Province/Region',
      name: 'secondArea',
      desc: '',
      args: [],
    );
  }

  /// `My Page`
  String get mypage {
    return Intl.message(
      'My Page',
      name: 'mypage',
      desc: '',
      args: [],
    );
  }

  /// `Register your username.`
  String get addUserName {
    return Intl.message(
      'Register your username.',
      name: 'addUserName',
      desc: '',
      args: [],
    );
  }

  /// `Post Management`
  String get postSetting {
    return Intl.message(
      'Post Management',
      name: 'postSetting',
      desc: '',
      args: [],
    );
  }

  /// `Written Missing Reports`
  String get writtenPost {
    return Intl.message(
      'Written Missing Reports',
      name: 'writtenPost',
      desc: '',
      args: [],
    );
  }

  /// `No written missing reports.`
  String get noPost {
    return Intl.message(
      'No written missing reports.',
      name: 'noPost',
      desc: '',
      args: [],
    );
  }

  /// `Written Witness Comments`
  String get writtenComment {
    return Intl.message(
      'Written Witness Comments',
      name: 'writtenComment',
      desc: '',
      args: [],
    );
  }

  /// `No written witness comments.`
  String get noComment {
    return Intl.message(
      'No written witness comments.',
      name: 'noComment',
      desc: '',
      args: [],
    );
  }

  /// `Bookmarked Missing Reports`
  String get bookmarkPost {
    return Intl.message(
      'Bookmarked Missing Reports',
      name: 'bookmarkPost',
      desc: '',
      args: [],
    );
  }

  /// `No bookmarked missing reports.`
  String get noBookmark {
    return Intl.message(
      'No bookmarked missing reports.',
      name: 'noBookmark',
      desc: '',
      args: [],
    );
  }

  /// `App Settings`
  String get appSetting {
    return Intl.message(
      'App Settings',
      name: 'appSetting',
      desc: '',
      args: [],
    );
  }

  /// `Notification Settings`
  String get pushSetting {
    return Intl.message(
      'Notification Settings',
      name: 'pushSetting',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logout {
    return Intl.message(
      'Log Out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get singout {
    return Intl.message(
      'Sign Out',
      name: 'singout',
      desc: '',
      args: [],
    );
  }

  /// `Exceeded maximum image selection`
  String get exceedImgNum {
    return Intl.message(
      'Exceeded maximum image selection',
      name: 'exceedImgNum',
      desc: '',
      args: [],
    );
  }

  /// `You can only register up to 3 images.`
  String get exceedImgNumAlert {
    return Intl.message(
      'You can only register up to 3 images.',
      name: 'exceedImgNumAlert',
      desc: '',
      args: [],
    );
  }

  /// `Submit Witness Comment`
  String get addComment {
    return Intl.message(
      'Submit Witness Comment',
      name: 'addComment',
      desc: '',
      args: [],
    );
  }

  /// `Witness comment registration is complete.`
  String get addCommentAlert {
    return Intl.message(
      'Witness comment registration is complete.',
      name: 'addCommentAlert',
      desc: '',
      args: [],
    );
  }

  /// `Failed to submit witness comment`
  String get failAddComment {
    return Intl.message(
      'Failed to submit witness comment',
      name: 'failAddComment',
      desc: '',
      args: [],
    );
  }

  /// `Failed to submit witness comment. Please try again.`
  String get failAddCommentAlert {
    return Intl.message(
      'Failed to submit witness comment. Please try again.',
      name: 'failAddCommentAlert',
      desc: '',
      args: [],
    );
  }

  /// `Delete Witness Comment`
  String get deleteComment {
    return Intl.message(
      'Delete Witness Comment',
      name: 'deleteComment',
      desc: '',
      args: [],
    );
  }

  /// `The witness comment has been deleted.`
  String get deleteCommentAlert {
    return Intl.message(
      'The witness comment has been deleted.',
      name: 'deleteCommentAlert',
      desc: '',
      args: [],
    );
  }

  /// `No address returned.`
  String get noAddress {
    return Intl.message(
      'No address returned.',
      name: 'noAddress',
      desc: '',
      args: [],
    );
  }

  /// `Try again with nearby locations.`
  String get tryAgainAdress {
    return Intl.message(
      'Try again with nearby locations.',
      name: 'tryAgainAdress',
      desc: '',
      args: [],
    );
  }

  /// `Submitted Witness Comment.`
  String get addCommentSnackBar {
    return Intl.message(
      'Submitted Witness Comment.',
      name: 'addCommentSnackBar',
      desc: '',
      args: [],
    );
  }

  /// `Witness Comment has been submitted successfully.`
  String get sucessAddComment {
    return Intl.message(
      'Witness Comment has been submitted successfully.',
      name: 'sucessAddComment',
      desc: '',
      args: [],
    );
  }

  /// `Failed to submit witness comment.`
  String get failComment {
    return Intl.message(
      'Failed to submit witness comment.',
      name: 'failComment',
      desc: '',
      args: [],
    );
  }

  /// `Failed to submit witness comment. Please try again.`
  String get tryAgainComment {
    return Intl.message(
      'Failed to submit witness comment. Please try again.',
      name: 'tryAgainComment',
      desc: '',
      args: [],
    );
  }

  /// `Add Missing Report`
  String get addReport {
    return Intl.message(
      'Add Missing Report',
      name: 'addReport',
      desc: '',
      args: [],
    );
  }

  /// `Your Report has been submitted successfully.`
  String get sucessAddReport {
    return Intl.message(
      'Your Report has been submitted successfully.',
      name: 'sucessAddReport',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save thumbnail selection`
  String get failThumbnail {
    return Intl.message(
      'Failed to save thumbnail selection',
      name: 'failThumbnail',
      desc: '',
      args: [],
    );
  }

  /// `Your Report has been submitted successfully.`
  String get sucessReport {
    return Intl.message(
      'Your Report has been submitted successfully.',
      name: 'sucessReport',
      desc: '',
      args: [],
    );
  }

  /// `Delete Missing Report`
  String get delReport {
    return Intl.message(
      'Delete Missing Report',
      name: 'delReport',
      desc: '',
      args: [],
    );
  }

  /// `Missing Report deleted.`
  String get delReportSnackBar {
    return Intl.message(
      'Missing Report deleted.',
      name: 'delReportSnackBar',
      desc: '',
      args: [],
    );
  }

  /// `Save Notification Settings`
  String get saveNoti {
    return Intl.message(
      'Save Notification Settings',
      name: 'saveNoti',
      desc: '',
      args: [],
    );
  }

  /// `Settings saved successfully.`
  String get sucessNoti {
    return Intl.message(
      'Settings saved successfully.',
      name: 'sucessNoti',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save notification settings`
  String get failSaveNoti {
    return Intl.message(
      'Failed to save notification settings',
      name: 'failSaveNoti',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save settings. Please try again.`
  String get failSaveNotiSnackBar {
    return Intl.message(
      'Failed to save settings. Please try again.',
      name: 'failSaveNotiSnackBar',
      desc: '',
      args: [],
    );
  }

  /// `Delete witness comment`
  String get delComment {
    return Intl.message(
      'Delete witness comment',
      name: 'delComment',
      desc: '',
      args: [],
    );
  }

  /// `Witness comment deleted.`
  String get delCommentSnackBar {
    return Intl.message(
      'Witness comment deleted.',
      name: 'delCommentSnackBar',
      desc: '',
      args: [],
    );
  }

  /// `Exceeded maximum image selection.`
  String get overImgNum {
    return Intl.message(
      'Exceeded maximum image selection.',
      name: 'overImgNum',
      desc: '',
      args: [],
    );
  }

  /// `You can input a maximum of 3 images.`
  String get overImgNumMsg {
    return Intl.message(
      'You can input a maximum of 3 images.',
      name: 'overImgNumMsg',
      desc: '',
      args: [],
    );
  }

  /// `Wait a moment! Have you checked before submitting the missing person report?`
  String get agreementTitle {
    return Intl.message(
      'Wait a moment! Have you checked before submitting the missing person report?',
      name: 'agreementTitle',
      desc: '',
      args: [],
    );
  }

  /// `I have reviewed the above content and agree.`
  String get agreementCheck {
    return Intl.message(
      'I have reviewed the above content and agree.',
      name: 'agreementCheck',
      desc: '',
      args: [],
    );
  }

  /// `According to Article 15 of the Personal Information Protection Act, personal information may be provided without the consent of the missing person if it is deemed necessary for the urgent benefit of the data subject or a third party's life, body, property, or in cases where the missing person or their legal representative is unable to express their intentions due to incapacity or unknown address, and it is clear that consent cannot be obtained in advance.\n\nUnder Article 71 of the Personal Information Protection Act, if personal information of the missing person is registered with MissingYou without meeting the aforementioned conditions, the registrant may face imprisonment for up to five years or a fine of up to 50 million won.\n\nFurthermore, according to Article 36 of the Personal Information Protection Act (Correction/Deletion of Personal Information), individuals who have accessed their personal information have the right to request its correction or deletion from MissingYou.\n\n• I acknowledge that under the Personal Information Protection Act, if it is not recognized as necessary for the urgent benefit of the missing person's life, body, or welfare, their personal information cannot be registered with the MissingYou app.\n\nIn other words, I understand that registering missing information with the intention of harming the life or body of the missing person, or unfairly infringing upon their property or other benefits, may result in penalties for violating the Personal Information Protection Act.\n\n• Additionally, I acknowledge that this declaration may serve as evidence of the intentions or consent of the author in case of legal issues.\n\n• I understand that, in accordance with Article 36 of the Personal Information Protection Act, missing reports may be deleted without separate notice to the author upon request from the data subject, the missing person.\n\n• I fully understand the above contents and solemnly pledge to handle the missing person's personal information appropriately.`
  String get agreementContent {
    return Intl.message(
      'According to Article 15 of the Personal Information Protection Act, personal information may be provided without the consent of the missing person if it is deemed necessary for the urgent benefit of the data subject or a third party\'s life, body, property, or in cases where the missing person or their legal representative is unable to express their intentions due to incapacity or unknown address, and it is clear that consent cannot be obtained in advance.\n\nUnder Article 71 of the Personal Information Protection Act, if personal information of the missing person is registered with MissingYou without meeting the aforementioned conditions, the registrant may face imprisonment for up to five years or a fine of up to 50 million won.\n\nFurthermore, according to Article 36 of the Personal Information Protection Act (Correction/Deletion of Personal Information), individuals who have accessed their personal information have the right to request its correction or deletion from MissingYou.\n\n• I acknowledge that under the Personal Information Protection Act, if it is not recognized as necessary for the urgent benefit of the missing person\'s life, body, or welfare, their personal information cannot be registered with the MissingYou app.\n\nIn other words, I understand that registering missing information with the intention of harming the life or body of the missing person, or unfairly infringing upon their property or other benefits, may result in penalties for violating the Personal Information Protection Act.\n\n• Additionally, I acknowledge that this declaration may serve as evidence of the intentions or consent of the author in case of legal issues.\n\n• I understand that, in accordance with Article 36 of the Personal Information Protection Act, missing reports may be deleted without separate notice to the author upon request from the data subject, the missing person.\n\n• I fully understand the above contents and solemnly pledge to handle the missing person\'s personal information appropriately.',
      name: 'agreementContent',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<I10n> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ko'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<I10n> load(Locale locale) => I10n.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
