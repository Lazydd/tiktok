// 最外层响应模型
class ApiResponse {
  final int code;
  final String message;
  final ResponseData data;

  ApiResponse({required this.code, required this.message, required this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      code: json['code'],
      message: json['message'],
      data: ResponseData.fromJson(json['data']),
    );
  }
}

// data 对象模型
class ResponseData {
  final int pageSize;
  final int pageNum;
  final int totalSize;
  final List<AwemeItem> items;

  ResponseData({
    required this.pageSize,
    required this.pageNum,
    required this.totalSize,
    required this.items,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    var itemsList = json['items'] as List;
    List<AwemeItem> items =
        itemsList.map((i) => AwemeItem.fromJson(i)).toList();

    return ResponseData(
      pageSize: json['pageSize'],
      pageNum: json['pageNum'],
      totalSize: json['totalSize'],
      items: items,
    );
  }
}

// 视频项模型（根据需要扩展嵌套字段）
class AwemeItem {
  final String awemeId;
  final String desc;
  final int createTime;
  final Music music;
  final Video video;

  AwemeItem({
    required this.awemeId,
    required this.desc,
    required this.createTime,
    required this.music,
    required this.video,
  });

  factory AwemeItem.fromJson(Map<String, dynamic> json) {
    return AwemeItem(
      awemeId: json['aweme_id'].toString(), // 转为字符串防止大数溢出
      desc: json['desc'] ?? '',
      createTime: json['create_time'] ?? 0,
      music: Music.fromJson(json['music']),
      video: Video.fromJson(json['video']),
    );
  }
}

// 音乐模型
class Music {
  final String id;
  final String title;
  final String author;

  Music({required this.id, required this.title, required this.author});

  factory Music.fromJson(Map<String, dynamic> json) {
    return Music(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      author: json['author'] ?? '',
    );
  }
}

// 视频模型
class Video {
  final PlayAddr playAddr;
  final int duration;

  Video({required this.playAddr, required this.duration});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      playAddr: PlayAddr.fromJson(json['play_addr']),
      duration: json['duration'] ?? 0,
    );
  }
}

// 播放地址模型
class PlayAddr {
  final List<String> urlList;

  PlayAddr({required this.urlList});

  factory PlayAddr.fromJson(Map<String, dynamic> json) {
    var urlList = (json['url_list'] as List).cast<String>();
    return PlayAddr(urlList: urlList);
  }
}
