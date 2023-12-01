class ResponseDTO<T>{
  String message = '';
  T data;
  bool status = false;
  String code = '400';

  ResponseDTO({this.message = '', required this.data,this.status = false,this.code = '400'});
}