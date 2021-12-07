class AuthApi{

  static String APIKEY='AIzaSyBN0jcvO2UCqAevfHuRssdBM1Qr9CabQYI';

  static get login {
    return 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$APIKEY';
  }
  static get signUp{
    return 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$APIKEY';
  }
  static get refreshToken{
    return 'https://securetoken.googleapis.com/v1/token?key=$APIKEY';
  }
}