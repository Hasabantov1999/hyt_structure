// ignore_for_file: file_names

abstract class IFileManager {
  Future<bool> writeUserRequestDataWithTime(String key, String model, Duration? time);
  Future<String?> getUserRequestDataOnString(String key);
  Future<bool> removeUserRequestSingleCache(String key);
  Future<bool> removeUserRequestCache(String key);
}
