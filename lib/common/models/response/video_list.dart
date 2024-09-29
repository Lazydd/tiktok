class VideoListItem {
  String? awemeId;
  String? desc;
  int? createTime;
  Music? music;
  Video? video;
  String? shareUrl;
  Statistics? statistics;
  Status? status;
  List<TextExtra>? textExtra;
  int? isTop;
  ShareInfo? shareInfo;
  int? duration;
  RiskInfos? riskInfos;
  int? authorUserId;
  bool? preventDownload;
  AwemeControl? awemeControl;
  List<SuggestWords>? suggestWords;

  VideoListItem(
      {this.awemeId,
      this.desc,
      this.createTime,
      this.music,
      this.video,
      this.shareUrl,
      this.statistics,
      this.status,
      this.textExtra,
      this.isTop,
      this.shareInfo,
      this.duration,
      this.riskInfos,
      this.authorUserId,
      this.preventDownload,
      this.awemeControl,
      this.suggestWords});

  VideoListItem.fromJson(Map<String, dynamic> json) {
    awemeId = json['aweme_id'];
    desc = json['desc'];
    createTime = json['create_time'];
    music = json['music'] != null ? Music.fromJson(json['music']) : null;
    video = json['video'] != null ? Video.fromJson(json['video']) : null;
    shareUrl = json['share_url'];
    statistics = json['statistics'] != null
        ? Statistics.fromJson(json['statistics'])
        : null;
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    if (json['text_extra'] != null) {
      textExtra = <TextExtra>[];
      json['text_extra'].forEach((v) {
        textExtra!.add(TextExtra.fromJson(v));
      });
    }
    isTop = json['is_top'];
    shareInfo = json['share_info'] != null
        ? ShareInfo.fromJson(json['share_info'])
        : null;
    duration = json['duration'];
    riskInfos = json['risk_infos'] != null
        ? RiskInfos.fromJson(json['risk_infos'])
        : null;
    authorUserId = json['author_user_id'];
    preventDownload = json['prevent_download'];
    awemeControl = json['aweme_control'] != null
        ? AwemeControl.fromJson(json['aweme_control'])
        : null;
    if (json['suggest_words'] != null) {
      suggestWords = <SuggestWords>[];
      json['suggest_words'].forEach((v) {
        suggestWords!.add(SuggestWords.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aweme_id'] = awemeId;
    data['desc'] = desc;
    data['create_time'] = createTime;
    if (music != null) {
      data['music'] = music!.toJson();
    }
    if (video != null) {
      data['video'] = video!.toJson();
    }
    data['share_url'] = shareUrl;
    if (statistics != null) {
      data['statistics'] = statistics!.toJson();
    }
    if (status != null) {
      data['status'] = status!.toJson();
    }
    if (textExtra != null) {
      data['text_extra'] = textExtra!.map((v) => v.toJson()).toList();
    }
    data['is_top'] = isTop;
    if (shareInfo != null) {
      data['share_info'] = shareInfo!.toJson();
    }
    data['duration'] = duration;
    if (riskInfos != null) {
      data['risk_infos'] = riskInfos!.toJson();
    }
    data['author_user_id'] = authorUserId;
    data['prevent_download'] = preventDownload;
    if (awemeControl != null) {
      data['aweme_control'] = awemeControl!.toJson();
    }
    if (suggestWords != null) {
      data['suggest_words'] = suggestWords!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Music {
  int? id;
  String? title;
  String? author;
  CoverMedium? coverMedium;
  CoverMedium? coverThumb;
  PlayUrl? playUrl;
  int? duration;
  int? userCount;
  String? ownerId;
  String? ownerNickname;
  bool? isOriginal;

  Music(
      {this.id,
      this.title,
      this.author,
      this.coverMedium,
      this.coverThumb,
      this.playUrl,
      this.duration,
      this.userCount,
      this.ownerId,
      this.ownerNickname,
      this.isOriginal});

  Music.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    coverMedium = json['cover_medium'] != null
        ? CoverMedium.fromJson(json['cover_medium'])
        : null;
    coverThumb = json['cover_thumb'] != null
        ? CoverMedium.fromJson(json['cover_thumb'])
        : null;
    playUrl =
        json['play_url'] != null ? PlayUrl.fromJson(json['play_url']) : null;
    duration = json['duration'];
    userCount = json['user_count'];
    ownerId = json['owner_id'];
    ownerNickname = json['owner_nickname'];
    isOriginal = json['is_original'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['author'] = author;
    if (coverMedium != null) {
      data['cover_medium'] = coverMedium!.toJson();
    }
    if (coverThumb != null) {
      data['cover_thumb'] = coverThumb!.toJson();
    }
    if (playUrl != null) {
      data['play_url'] = playUrl!.toJson();
    }
    data['duration'] = duration;
    data['user_count'] = userCount;
    data['owner_id'] = ownerId;
    data['owner_nickname'] = ownerNickname;
    data['is_original'] = isOriginal;
    return data;
  }
}

class CoverMedium {
  String? uri;
  List<String>? urlList;
  int? width;
  int? height;

  CoverMedium({this.uri, this.urlList, this.width, this.height});

  CoverMedium.fromJson(Map<String, dynamic> json) {
    uri = json['uri'];
    urlList = json['url_list'].cast<String>();
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uri'] = uri;
    data['url_list'] = urlList;
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}

class PlayUrl {
  String? uri;
  List<String>? urlList;
  int? width;
  int? height;
  String? urlKey;

  PlayUrl({this.uri, this.urlList, this.width, this.height, this.urlKey});

  PlayUrl.fromJson(Map<String, dynamic> json) {
    uri = json['uri'];
    urlList = json['url_list'].cast<String>();
    width = json['width'];
    height = json['height'];
    urlKey = json['url_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uri'] = uri;
    data['url_list'] = urlList;
    data['width'] = width;
    data['height'] = height;
    data['url_key'] = urlKey;
    return data;
  }
}

class Video {
  PlayAddr? playAddr;
  CoverMedium? cover;
  int? height;
  int? width;
  String? ratio;
  bool? useStaticCover;
  int? duration;

  Video(
      {this.playAddr,
      this.cover,
      this.height,
      this.width,
      this.ratio,
      this.useStaticCover,
      this.duration});

  Video.fromJson(Map<String, dynamic> json) {
    playAddr =
        json['play_addr'] != null ? PlayAddr.fromJson(json['play_addr']) : null;
    cover = json['cover'] != null ? CoverMedium.fromJson(json['cover']) : null;
    height = json['height'];
    width = json['width'];
    ratio = json['ratio'];
    useStaticCover = json['use_static_cover'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (playAddr != null) {
      data['play_addr'] = playAddr!.toJson();
    }
    if (cover != null) {
      data['cover'] = cover!.toJson();
    }
    data['height'] = height;
    data['width'] = width;
    data['ratio'] = ratio;
    data['use_static_cover'] = useStaticCover;
    data['duration'] = duration;
    return data;
  }
}

class PlayAddr {
  String? uri;
  List<String>? urlList;
  int? width;
  int? height;
  String? urlKey;
  int? dataSize;
  String? fileHash;
  String? fileCs;

  PlayAddr(
      {this.uri,
      this.urlList,
      this.width,
      this.height,
      this.urlKey,
      this.dataSize,
      this.fileHash,
      this.fileCs});

  PlayAddr.fromJson(Map<String, dynamic> json) {
    uri = json['uri'];
    urlList = json['url_list'].cast<String>();
    width = json['width'];
    height = json['height'];
    urlKey = json['url_key'];
    dataSize = json['data_size'];
    fileHash = json['file_hash'];
    fileCs = json['file_cs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uri'] = uri;
    data['url_list'] = urlList;
    data['width'] = width;
    data['height'] = height;
    data['url_key'] = urlKey;
    data['data_size'] = dataSize;
    data['file_hash'] = fileHash;
    data['file_cs'] = fileCs;
    return data;
  }
}

class Statistics {
  int? admireCount;
  int? commentCount;
  int? diggCount;
  int? collectCount;
  int? playCount;
  int? shareCount;

  Statistics(
      {this.admireCount,
      this.commentCount,
      this.diggCount,
      this.collectCount,
      this.playCount,
      this.shareCount});

  Statistics.fromJson(Map<String, dynamic> json) {
    admireCount = json['admire_count'];
    commentCount = json['comment_count'];
    diggCount = json['digg_count'];
    collectCount = json['collect_count'];
    playCount = json['play_count'];
    shareCount = json['share_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['admire_count'] = admireCount;
    data['comment_count'] = commentCount;
    data['digg_count'] = diggCount;
    data['collect_count'] = collectCount;
    data['play_count'] = playCount;
    data['share_count'] = shareCount;
    return data;
  }
}

class Status {
  int? listenVideoStatus;
  bool? isDelete;
  bool? allowShare;
  bool? isProhibited;
  bool? inReviewing;
  int? partSee;
  int? privateStatus;
  ReviewResult? reviewResult;

  Status(
      {this.listenVideoStatus,
      this.isDelete,
      this.allowShare,
      this.isProhibited,
      this.inReviewing,
      this.partSee,
      this.privateStatus,
      this.reviewResult});

  Status.fromJson(Map<String, dynamic> json) {
    listenVideoStatus = json['listen_video_status'];
    isDelete = json['is_delete'];
    allowShare = json['allow_share'];
    isProhibited = json['is_prohibited'];
    inReviewing = json['in_reviewing'];
    partSee = json['part_see'];
    privateStatus = json['private_status'];
    reviewResult = json['review_result'] != null
        ? ReviewResult.fromJson(json['review_result'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['listen_video_status'] = listenVideoStatus;
    data['is_delete'] = isDelete;
    data['allow_share'] = allowShare;
    data['is_prohibited'] = isProhibited;
    data['in_reviewing'] = inReviewing;
    data['part_see'] = partSee;
    data['private_status'] = privateStatus;
    if (reviewResult != null) {
      data['review_result'] = reviewResult!.toJson();
    }
    return data;
  }
}

class ReviewResult {
  int? reviewStatus;

  ReviewResult({this.reviewStatus});

  ReviewResult.fromJson(Map<String, dynamic> json) {
    reviewStatus = json['review_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['review_status'] = reviewStatus;
    return data;
  }
}

class TextExtra {
  int? start;
  int? end;
  int? type;
  String? hashtagName;
  String? hashtagId;
  bool? isCommerce;
  int? captionStart;
  int? captionEnd;

  TextExtra(
      {this.start,
      this.end,
      this.type,
      this.hashtagName,
      this.hashtagId,
      this.isCommerce,
      this.captionStart,
      this.captionEnd});

  TextExtra.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
    type = json['type'];
    hashtagName = json['hashtag_name'];
    hashtagId = json['hashtag_id'];
    isCommerce = json['is_commerce'];
    captionStart = json['caption_start'];
    captionEnd = json['caption_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start'] = start;
    data['end'] = end;
    data['type'] = type;
    data['hashtag_name'] = hashtagName;
    data['hashtag_id'] = hashtagId;
    data['is_commerce'] = isCommerce;
    data['caption_start'] = captionStart;
    data['caption_end'] = captionEnd;
    return data;
  }
}

class ShareInfo {
  String? shareUrl;
  String? shareLinkDesc;

  ShareInfo({this.shareUrl, this.shareLinkDesc});

  ShareInfo.fromJson(Map<String, dynamic> json) {
    shareUrl = json['share_url'];
    shareLinkDesc = json['share_link_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['share_url'] = shareUrl;
    data['share_link_desc'] = shareLinkDesc;
    return data;
  }
}

class RiskInfos {
  bool? vote;
  bool? warn;
  bool? riskSink;
  int? type;
  String? content;

  RiskInfos({this.vote, this.warn, this.riskSink, this.type, this.content});

  RiskInfos.fromJson(Map<String, dynamic> json) {
    vote = json['vote'];
    warn = json['warn'];
    riskSink = json['risk_sink'];
    type = json['type'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vote'] = vote;
    data['warn'] = warn;
    data['risk_sink'] = riskSink;
    data['type'] = type;
    data['content'] = content;
    return data;
  }
}

class AwemeControl {
  bool? canForward;
  bool? canShare;
  bool? canComment;
  bool? canShowComment;

  AwemeControl(
      {this.canForward, this.canShare, this.canComment, this.canShowComment});

  AwemeControl.fromJson(Map<String, dynamic> json) {
    canForward = json['can_forward'];
    canShare = json['can_share'];
    canComment = json['can_comment'];
    canShowComment = json['can_show_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['can_forward'] = canForward;
    data['can_share'] = canShare;
    data['can_comment'] = canComment;
    data['can_show_comment'] = canShowComment;
    return data;
  }
}

class SuggestWords {
  List<Words>? words;
  String? scene;
  String? iconUrl;
  String? hintText;
  String? extraInfo;

  SuggestWords(
      {this.words, this.scene, this.iconUrl, this.hintText, this.extraInfo});

  SuggestWords.fromJson(Map<String, dynamic> json) {
    if (json['words'] != null) {
      words = <Words>[];
      json['words'].forEach((v) {
        words!.add(Words.fromJson(v));
      });
    }
    scene = json['scene'];
    iconUrl = json['icon_url'];
    hintText = json['hint_text'];
    extraInfo = json['extra_info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (words != null) {
      data['words'] = words!.map((v) => v.toJson()).toList();
    }
    data['scene'] = scene;
    data['icon_url'] = iconUrl;
    data['hint_text'] = hintText;
    data['extra_info'] = extraInfo;
    return data;
  }
}

class Words {
  String? word;
  String? wordId;
  String? info;

  Words({this.word, this.wordId, this.info});

  Words.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    wordId = json['word_id'];
    info = json['info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['word'] = word;
    data['word_id'] = wordId;
    data['info'] = info;
    return data;
  }
}
