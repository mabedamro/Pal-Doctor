class DataApi {
  static String baseUrl =
      'https://firestore.googleapis.com/v1/projects/pal-doctor/databases/(default)/documents';
  static get usersApi {
    return baseUrl + '/users';
  }
}
