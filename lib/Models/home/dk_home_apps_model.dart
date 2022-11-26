class DKHomeAppsModel {
  List<Apps>? apps;

  DKHomeAppsModel({this.apps});

  DKHomeAppsModel.fromJson(Map<String, dynamic> json) {
    if (json['apps'] != null) {
      apps = <Apps>[];
      json['apps'].forEach((v) {
        apps!.add(Apps.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (apps != null) {
      data['apps'] = apps!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Apps {
  String? name;
  String? image;
  String? route;

  Apps({this.name, this.image, this.route});

  Apps.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    route = json['route'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['route'] = route;
    return data;
  }
}