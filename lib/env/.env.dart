const bool isProduction = bool.fromEnvironment('dart.vm.product');

const devConfig = {
  // 아이폰 시뮬레이터일 경우
  // 'baseUrl': 'https://krrng_client.co.kr/',
  'baseUrl': 'http://localhost:8000/',
  // 안드로이드 에뮬레이터일 경우
  // 'baseUrl': 'http://10.0.2.2:8000/',
  // 'kakaoUrl': 'http://127.0.0.1:1234/',
};
const productionConfig = {
  // 'baseUrl': 'https://krrng_client.co.kr/',
  'baseUrl': 'http://localhost:8000/',
  // 'baseUrl': 'http://10.0.2.2:8000/',
  // 'kakaoUrl': 'http://localhost:1234/',
};

const environment = isProduction ? productionConfig : devConfig;

const mapAPI = "https://naveropenapi.apigw.ntruss.com";
const Map<String,String> naverHeaders = {
  'X-NCP-APIGW-API-KEY-ID': '392xygymnv', // 개인 클라이언트 아이디
  'X-NCP-APIGW-API-KEY': 'njSEcXknlKEVa9GTZKjaMRMsIdBs4qvPKgclwq08',
  'Content-Type': 'application/json; charset=UTF-8'// 개인 시크릿 키
};