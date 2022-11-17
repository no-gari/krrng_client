const bool isProduction = bool.fromEnvironment('dart.vm.product');

const devConfig = {
  // 아이폰 시뮬레이터일 경우
  // 'baseUrl': 'https://krrng_client.co.kr/',
  'baseUrl': 'https://6vvpl67pw2.execute-api.ap-northeast-2.amazonaws.com',
  // 안드로이드 에뮬레이터일 경우
  // 'baseUrl': 'http://10.0.2.2:8000/',
  // 'kakaoUrl': 'http://127.0.0.1:1234/',
};
const productionConfig = {
  // 'baseUrl': 'https://krrng_client.co.kr/',
  'baseUrl': 'https://6vvpl67pw2.execute-api.ap-northeast-2.amazonaws.com',
  // 'baseUrl': 'http://10.0.2.2:8000/',
  // 'kakaoUrl': 'http://localhost:1234/',
};
const environment = isProduction ? productionConfig : devConfig;
