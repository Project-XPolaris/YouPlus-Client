import 'package:dio/dio.dart';
import 'package:youplus/api/app.dart';
import 'package:youplus/api/auth.dart';
import 'package:youplus/api/base.dart';
import 'package:youplus/api/disk_list_response.dart';
import 'package:youplus/api/folder.dart';
import 'package:youplus/api/info.dart';

import '../config.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  static Dio _dio = new Dio();
  factory ApiClient() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest:(RequestOptions options, RequestInterceptorHandler handler) async {
        var serviceUrl = ApplicationConfig().serviceUrl;
        if (serviceUrl != null) {
          options.baseUrl = serviceUrl;
        }
        String? token = ApplicationConfig().token;
        if (token != null && token.isNotEmpty) {
          options.headers = {
            "Authorization": "Bearer $token"
          };
        }
        options.validateStatus = (status) {
          if (status == null) {
            return false;
          }
          return status < 600;
        };
        handler.next(options);
      },
    ));
    return _instance;
  }
  Future<UserAuthResponse> userAuth(String username,String password) async {
    var response = await _dio.post("/admin/auth",data: {
      "username":username,"password":password
    });
    print(response.data);
    UserAuthResponse authResponse = UserAuthResponse.fromJson(response.data);
    return authResponse;
  }
  Future<BaseResponse> checkToken(String token) async {
    var response = await _dio.get("/user/auth",queryParameters: {"token":token});
    BaseResponse baseResponse = BaseResponse.fromJson(response.data);
    return baseResponse;
  }
  Future<DeviceInfo> fetchDeviceInfo() async {
    var response = await _dio.get("/system/info");
    return DeviceInfo.fromJson(response.data);
  }
  Future<List<AppResponse>> fetchAppList()  async {
    var response = await _dio.get("/apps");
    var appList  = response.data["apps"];
    List<AppResponse> list = [];
    appList.forEach((element) {
      list.add(AppResponse.fromJson(element));
    });
    return list;
  }
  Future<List<ShareFolder>> fetchShareFolderList()  async {
    var response = await _dio.get("/share");
    var folders  = response.data["folders"];
    List<ShareFolder> list = [];
    folders.forEach((element) {
      list.add(ShareFolder.fromJson(element));
    });
    return list;
  }
  Future<BaseResponse> startApp(String id)  async {
    var response = await _dio.post("/app/run",queryParameters: {"id":id});
    print(response);
    return BaseResponse.fromJson(response.data);
  }
  Future<BaseResponse> stopApp(String id)  async {
    var response = await _dio.post("/app/stop",queryParameters: {"id":id});
    return BaseResponse.fromJson(response.data);
  }
  Future<BaseResponse> shutdown()  async {
    var response = await _dio.post("/os/shutdown");
    return BaseResponse.fromJson(response.data);
  }
  Future<BaseResponse> reboot()  async {
    var response = await _dio.post("/os/reboot");
    return BaseResponse.fromJson(response.data);
  }
  Future<NasInfo> fetchNasInfo() async {
    var response = await _dio.get("/device/info");
    return NasInfo.fromJson(response.data);
  }
  Future<DiskListResponse> fetchDiskList() async{
    var response = await _dio.get("/disks");
    return DiskListResponse.fromJson(response.data);
  }
  ApiClient._internal();
}