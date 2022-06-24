// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

List<NewsModel> newsModelFromJson(String str) => List<NewsModel>.from(json.decode(str).map((x) => NewsModel.fromJson(x)));

String newsModelToJson(List<NewsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsModel {
  NewsModel({
    this.id,
    this.date,
    this.dateGmt,
    this.guid,
    this.modified,
    this.modifiedGmt,
    this.slug,
    this.status,
    this.type,
    this.link,
    this.title,
    this.content,
    this.excerpt,
    this.author,
    this.featuredMedia,
    this.commentStatus,
    this.pingStatus,
    this.sticky,
    this.template,
    this.format,
    this.meta,
    this.categories,
    this.tags,
    this.yoastHead,
    this.yoastHeadJson,
    this.links,
  });

  int id;
  DateTime date;
  DateTime dateGmt;
  Guid guid;
  DateTime modified;
  DateTime modifiedGmt;
  String slug;
  StatusEnum status;
  NewsModelType type;
  String link;
  Guid title;
  Content content;
  Content excerpt;
  int author;
  int featuredMedia;
  Status commentStatus;
  Status pingStatus;
  bool sticky;
  String template;
  Format format;
  List<dynamic> meta;
  List<int> categories;
  List<int> tags;
  String yoastHead;
  YoastHeadJson yoastHeadJson;
  Links links;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    id: json["id"],
    date: DateTime.parse(json["date"]),
    dateGmt: DateTime.parse(json["date_gmt"]),
    guid: Guid.fromJson(json["guid"]),
    modified: DateTime.parse(json["modified"]),
    modifiedGmt: DateTime.parse(json["modified_gmt"]),
    slug: json["slug"],
    status: statusEnumValues.map[json["status"]],
    type: newsModelTypeValues.map[json["type"]],
    link: json["link"],
    title: Guid.fromJson(json["title"]),
    content: Content.fromJson(json["content"]),
    excerpt: Content.fromJson(json["excerpt"]),
    author: json["author"],
    featuredMedia: json["featured_media"],
    commentStatus: statusValues.map[json["comment_status"]],
    pingStatus: statusValues.map[json["ping_status"]],
    sticky: json["sticky"],
    template: json["template"],
    format: formatValues.map[json["format"]],
    meta: List<dynamic>.from(json["meta"].map((x) => x)),
    categories: List<int>.from(json["categories"].map((x) => x)),
    tags: List<int>.from(json["tags"].map((x) => x)),
    yoastHead: json["yoast_head"],
    yoastHeadJson: YoastHeadJson.fromJson(json["yoast_head_json"]),
    links: Links.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date.toIso8601String(),
    "date_gmt": dateGmt.toIso8601String(),
    "guid": guid.toJson(),
    "modified": modified.toIso8601String(),
    "modified_gmt": modifiedGmt.toIso8601String(),
    "slug": slug,
    "status": statusEnumValues.reverse[status],
    "type": newsModelTypeValues.reverse[type],
    "link": link,
    "title": title.toJson(),
    "content": content.toJson(),
    "excerpt": excerpt.toJson(),
    "author": author,
    "featured_media": featuredMedia,
    "comment_status": statusValues.reverse[commentStatus],
    "ping_status": statusValues.reverse[pingStatus],
    "sticky": sticky,
    "template": template,
    "format": formatValues.reverse[format],
    "meta": List<dynamic>.from(meta.map((x) => x)),
    "categories": List<dynamic>.from(categories.map((x) => x)),
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "yoast_head": yoastHead,
    "yoast_head_json": yoastHeadJson.toJson(),
    "_links": links.toJson(),
  };
}

enum Status { CLOSED }

final statusValues = EnumValues({
  "closed": Status.CLOSED
});

class Content {
  Content({
    this.rendered,
    this.protected,
  });

  String rendered;
  bool protected;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    rendered: json["rendered"],
    protected: json["protected"],
  );

  Map<String, dynamic> toJson() => {
    "rendered": rendered,
    "protected": protected,
  };
}

enum Format { STANDARD }

final formatValues = EnumValues({
  "standard": Format.STANDARD
});

class Guid {
  Guid({
    this.rendered,
  });

  String rendered;

  factory Guid.fromJson(Map<String, dynamic> json) => Guid(
    rendered: json["rendered"],
  );

  Map<String, dynamic> toJson() => {
    "rendered": rendered,
  };
}

class Links {
  Links({
    this.self,
    this.collection,
    this.about,
    this.author,
    this.replies,
    this.versionHistory,
    this.predecessorVersion,
    this.wpFeaturedmedia,
    this.wpAttachment,
    this.wpTerm,
    this.curies,
  });

  List<About> self;
  List<About> collection;
  List<About> about;
  List<AuthorElement> author;
  List<AuthorElement> replies;
  List<VersionHistory> versionHistory;
  List<PredecessorVersion> predecessorVersion;
  List<AuthorElement> wpFeaturedmedia;
  List<About> wpAttachment;
  List<WpTerm> wpTerm;
  List<Cury> curies;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: List<About>.from(json["self"].map((x) => About.fromJson(x))),
    collection: List<About>.from(json["collection"].map((x) => About.fromJson(x))),
    about: List<About>.from(json["about"].map((x) => About.fromJson(x))),
    author: List<AuthorElement>.from(json["author"].map((x) => AuthorElement.fromJson(x))),
    replies: List<AuthorElement>.from(json["replies"].map((x) => AuthorElement.fromJson(x))),
    versionHistory: List<VersionHistory>.from(json["version-history"].map((x) => VersionHistory.fromJson(x))),
    predecessorVersion: List<PredecessorVersion>.from(json["predecessor-version"].map((x) => PredecessorVersion.fromJson(x))),
    wpFeaturedmedia: List<AuthorElement>.from(json["wp:featuredmedia"].map((x) => AuthorElement.fromJson(x))),
    wpAttachment: List<About>.from(json["wp:attachment"].map((x) => About.fromJson(x))),
    wpTerm: List<WpTerm>.from(json["wp:term"].map((x) => WpTerm.fromJson(x))),
    curies: List<Cury>.from(json["curies"].map((x) => Cury.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "self": List<dynamic>.from(self.map((x) => x.toJson())),
    "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
    "about": List<dynamic>.from(about.map((x) => x.toJson())),
    "author": List<dynamic>.from(author.map((x) => x.toJson())),
    "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
    "version-history": List<dynamic>.from(versionHistory.map((x) => x.toJson())),
    "predecessor-version": List<dynamic>.from(predecessorVersion.map((x) => x.toJson())),
    "wp:featuredmedia": List<dynamic>.from(wpFeaturedmedia.map((x) => x.toJson())),
    "wp:attachment": List<dynamic>.from(wpAttachment.map((x) => x.toJson())),
    "wp:term": List<dynamic>.from(wpTerm.map((x) => x.toJson())),
    "curies": List<dynamic>.from(curies.map((x) => x.toJson())),
  };
}

class About {
  About({
    this.href,
  });

  String href;

  factory About.fromJson(Map<String, dynamic> json) => About(
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
  };
}

class AuthorElement {
  AuthorElement({
    this.embeddable,
    this.href,
  });

  bool embeddable;
  String href;

  factory AuthorElement.fromJson(Map<String, dynamic> json) => AuthorElement(
    embeddable: json["embeddable"],
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "embeddable": embeddable,
    "href": href,
  };
}

class Cury {
  Cury({
    this.name,
    this.href,
    this.templated,
  });

  Name name;
  Href href;
  bool templated;

  factory Cury.fromJson(Map<String, dynamic> json) => Cury(
    name: nameValues.map[json["name"]],
    href: hrefValues.map[json["href"]],
    templated: json["templated"],
  );

  Map<String, dynamic> toJson() => {
    "name": nameValues.reverse[name],
    "href": hrefValues.reverse[href],
    "templated": templated,
  };
}

enum Href { HTTPS_API_W_ORG_REL }

final hrefValues = EnumValues({
  "https://api.w.org/{rel}": Href.HTTPS_API_W_ORG_REL
});

enum Name { WP }

final nameValues = EnumValues({
  "wp": Name.WP
});

class PredecessorVersion {
  PredecessorVersion({
    this.id,
    this.href,
  });

  int id;
  String href;

  factory PredecessorVersion.fromJson(Map<String, dynamic> json) => PredecessorVersion(
    id: json["id"],
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "href": href,
  };
}

class VersionHistory {
  VersionHistory({
    this.count,
    this.href,
  });

  int count;
  String href;

  factory VersionHistory.fromJson(Map<String, dynamic> json) => VersionHistory(
    count: json["count"],
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "href": href,
  };
}

class WpTerm {
  WpTerm({
    this.taxonomy,
    this.embeddable,
    this.href,
  });

  Taxonomy taxonomy;
  bool embeddable;
  String href;

  factory WpTerm.fromJson(Map<String, dynamic> json) => WpTerm(
    taxonomy: taxonomyValues.map[json["taxonomy"]],
    embeddable: json["embeddable"],
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "taxonomy": taxonomyValues.reverse[taxonomy],
    "embeddable": embeddable,
    "href": href,
  };
}

enum Taxonomy { CATEGORY, POST_TAG }

final taxonomyValues = EnumValues({
  "category": Taxonomy.CATEGORY,
  "post_tag": Taxonomy.POST_TAG
});

enum StatusEnum { PUBLISH }

final statusEnumValues = EnumValues({
  "publish": StatusEnum.PUBLISH
});

enum NewsModelType { POST }

final newsModelTypeValues = EnumValues({
  "post": NewsModelType.POST
});

class YoastHeadJson {
  YoastHeadJson({
    this.title,
    this.description,
    this.robots,
    this.canonical,
    this.ogLocale,
    this.ogType,
    this.ogTitle,
    this.ogDescription,
    this.ogUrl,
    this.ogSiteName,
    this.articlePublisher,
    this.articlePublishedTime,
    this.ogImage,
    this.twitterCard,
    this.twitterCreator,
    this.twitterSite,
    this.twitterMisc,
    this.schema,
    this.articleModifiedTime,
  });

  String title;
  String description;
  Robots robots;
  String canonical;
  OgLocale ogLocale;
  OgType ogType;
  String ogTitle;
  String ogDescription;
  String ogUrl;
  OgSiteName ogSiteName;
  String articlePublisher;
  DateTime articlePublishedTime;
  List<OgImage> ogImage;
  TwitterCard twitterCard;
  Twitter twitterCreator;
  Twitter twitterSite;
  TwitterMisc twitterMisc;
  Schema schema;
  DateTime articleModifiedTime;

  factory YoastHeadJson.fromJson(Map<String, dynamic> json) => YoastHeadJson(
    title: json["title"],
    description: json["description"],
    robots: Robots.fromJson(json["robots"]),
    canonical: json["canonical"],
    ogLocale: ogLocaleValues.map[json["og_locale"]],
    ogType: ogTypeValues.map[json["og_type"]],
    ogTitle: json["og_title"],
    ogDescription: json["og_description"],
    ogUrl: json["og_url"],
    ogSiteName: ogSiteNameValues.map[json["og_site_name"]],
    articlePublisher: json["article_publisher"],
    articlePublishedTime: DateTime.parse(json["article_published_time"]),
    ogImage: List<OgImage>.from(json["og_image"].map((x) => OgImage.fromJson(x))),
    twitterCard: twitterCardValues.map[json["twitter_card"]],
    twitterCreator: twitterValues.map[json["twitter_creator"]],
    twitterSite: twitterValues.map[json["twitter_site"]],
    twitterMisc: TwitterMisc.fromJson(json["twitter_misc"]),
    schema: Schema.fromJson(json["schema"]),
    articleModifiedTime: json["article_modified_time"] == null ? null : DateTime.parse(json["article_modified_time"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "robots": robots.toJson(),
    "canonical": canonical,
    "og_locale": ogLocaleValues.reverse[ogLocale],
    "og_type": ogTypeValues.reverse[ogType],
    "og_title": ogTitle,
    "og_description": ogDescription,
    "og_url": ogUrl,
    "og_site_name": ogSiteNameValues.reverse[ogSiteName],
    "article_publisher": articlePublisher,
    "article_published_time": articlePublishedTime.toIso8601String(),
    "og_image": List<dynamic>.from(ogImage.map((x) => x.toJson())),
    "twitter_card": twitterCardValues.reverse[twitterCard],
    "twitter_creator": twitterValues.reverse[twitterCreator],
    "twitter_site": twitterValues.reverse[twitterSite],
    "twitter_misc": twitterMisc.toJson(),
    "schema": schema.toJson(),
    "article_modified_time": articleModifiedTime == null ? null : articleModifiedTime.toIso8601String(),
  };
}

class OgImage {
  OgImage({
    this.width,
    this.height,
    this.url,
    this.type,
  });

  int width;
  int height;
  String url;
  OgImageType type;

  factory OgImage.fromJson(Map<String, dynamic> json) => OgImage(
    width: json["width"],
    height: json["height"],
    url: json["url"],
    type: ogImageTypeValues.map[json["type"]],
  );

  Map<String, dynamic> toJson() => {
    "width": width,
    "height": height,
    "url": url,
    "type": ogImageTypeValues.reverse[type],
  };
}

enum OgImageType { IMAGE_JPEG, IMAGE_PNG }

final ogImageTypeValues = EnumValues({
  "image/jpeg": OgImageType.IMAGE_JPEG,
  "image/png": OgImageType.IMAGE_PNG
});

enum OgLocale { EN_US }

final ogLocaleValues = EnumValues({
  "en_US": OgLocale.EN_US
});

enum OgSiteName { NEWS_BTC }

final ogSiteNameValues = EnumValues({
  "NewsBTC": OgSiteName.NEWS_BTC
});

enum OgType { ARTICLE }

final ogTypeValues = EnumValues({
  "article": OgType.ARTICLE
});

class Robots {
  Robots({
    this.index,
    this.follow,
    this.maxSnippet,
    this.maxImagePreview,
    this.maxVideoPreview,
  });

  Index index;
  Follow follow;
  MaxSnippet maxSnippet;
  MaxImagePreview maxImagePreview;
  MaxVideoPreview maxVideoPreview;

  factory Robots.fromJson(Map<String, dynamic> json) => Robots(
    index: indexValues.map[json["index"]],
    follow: followValues.map[json["follow"]],
    maxSnippet: maxSnippetValues.map[json["max-snippet"]],
    maxImagePreview: maxImagePreviewValues.map[json["max-image-preview"]],
    maxVideoPreview: maxVideoPreviewValues.map[json["max-video-preview"]],
  );

  Map<String, dynamic> toJson() => {
    "index": indexValues.reverse[index],
    "follow": followValues.reverse[follow],
    "max-snippet": maxSnippetValues.reverse[maxSnippet],
    "max-image-preview": maxImagePreviewValues.reverse[maxImagePreview],
    "max-video-preview": maxVideoPreviewValues.reverse[maxVideoPreview],
  };
}

enum Follow { FOLLOW }

final followValues = EnumValues({
  "follow": Follow.FOLLOW
});

enum Index { INDEX }

final indexValues = EnumValues({
  "index": Index.INDEX
});

enum MaxImagePreview { MAX_IMAGE_PREVIEW_LARGE }

final maxImagePreviewValues = EnumValues({
  "max-image-preview:large": MaxImagePreview.MAX_IMAGE_PREVIEW_LARGE
});

enum MaxSnippet { MAX_SNIPPET_1 }

final maxSnippetValues = EnumValues({
  "max-snippet:-1": MaxSnippet.MAX_SNIPPET_1
});

enum MaxVideoPreview { MAX_VIDEO_PREVIEW_1 }

final maxVideoPreviewValues = EnumValues({
  "max-video-preview:-1": MaxVideoPreview.MAX_VIDEO_PREVIEW_1
});

class Schema {
  Schema({
    this.context,
    this.graph,
  });

  String context;
  List<Graph> graph;

  factory Schema.fromJson(Map<String, dynamic> json) => Schema(
    context: json["@context"],
    graph: List<Graph>.from(json["@graph"].map((x) => Graph.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "@context": context,
    "@graph": List<dynamic>.from(graph.map((x) => x.toJson())),
  };
}

class Graph {
  Graph({
    this.type,
    this.id,
    this.name,
    this.url,
    this.sameAs,
    this.logo,
    this.image,
    this.description,
    this.publisher,
    this.potentialAction,
    this.inLanguage,
    this.contentUrl,
    this.width,
    this.height,
    this.caption,
    this.isPartOf,
    this.primaryImageOfPage,
    this.datePublished,
    this.dateModified,
    this.breadcrumb,
    this.itemListElement,
    this.author,
    this.headline,
    this.mainEntityOfPage,
    this.wordCount,
    this.thumbnailUrl,
    this.keywords,
    this.articleSection,
  });

  GraphType type;
  String id;
  String name;
  String url;
  List<String> sameAs;
  Image logo;
  Image image;
  String description;
  BreadcrumbClass publisher;
  List<PotentialAction> potentialAction;
  InLanguage inLanguage;
  String contentUrl;
  int width;
  int height;
  String caption;
  BreadcrumbClass isPartOf;
  BreadcrumbClass primaryImageOfPage;
  DateTime datePublished;
  DateTime dateModified;
  BreadcrumbClass breadcrumb;
  List<ItemListElement> itemListElement;
  BreadcrumbClass author;
  String headline;
  BreadcrumbClass mainEntityOfPage;
  int wordCount;
  String thumbnailUrl;
  List<String> keywords;
  List<String> articleSection;

  factory Graph.fromJson(Map<String, dynamic> json) => Graph(
    type: graphTypeValues.map[json["@type"]],
    id: json["@id"],
    name: json["name"] == null ? null : json["name"],
    url: json["url"] == null ? null : json["url"],
    sameAs: json["sameAs"] == null ? null : List<String>.from(json["sameAs"].map((x) => x)),
    logo: json["logo"] == null ? null : Image.fromJson(json["logo"]),
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
    description: json["description"] == null ? null : json["description"],
    publisher: json["publisher"] == null ? null : BreadcrumbClass.fromJson(json["publisher"]),
    potentialAction: json["potentialAction"] == null ? null : List<PotentialAction>.from(json["potentialAction"].map((x) => PotentialAction.fromJson(x))),
    inLanguage: json["inLanguage"] == null ? null : inLanguageValues.map[json["inLanguage"]],
    contentUrl: json["contentUrl"] == null ? null : json["contentUrl"],
    width: json["width"] == null ? null : json["width"],
    height: json["height"] == null ? null : json["height"],
    caption: json["caption"] == null ? null : json["caption"],
    isPartOf: json["isPartOf"] == null ? null : BreadcrumbClass.fromJson(json["isPartOf"]),
    primaryImageOfPage: json["primaryImageOfPage"] == null ? null : BreadcrumbClass.fromJson(json["primaryImageOfPage"]),
    datePublished: json["datePublished"] == null ? null : DateTime.parse(json["datePublished"]),
    dateModified: json["dateModified"] == null ? null : DateTime.parse(json["dateModified"]),
    breadcrumb: json["breadcrumb"] == null ? null : BreadcrumbClass.fromJson(json["breadcrumb"]),
    itemListElement: json["itemListElement"] == null ? null : List<ItemListElement>.from(json["itemListElement"].map((x) => ItemListElement.fromJson(x))),
    author: json["author"] == null ? null : BreadcrumbClass.fromJson(json["author"]),
    headline: json["headline"] == null ? null : json["headline"],
    mainEntityOfPage: json["mainEntityOfPage"] == null ? null : BreadcrumbClass.fromJson(json["mainEntityOfPage"]),
    wordCount: json["wordCount"] == null ? null : json["wordCount"],
    thumbnailUrl: json["thumbnailUrl"] == null ? null : json["thumbnailUrl"],
    keywords: json["keywords"] == null ? null : List<String>.from(json["keywords"].map((x) => x)),
    articleSection: json["articleSection"] == null ? null : List<String>.from(json["articleSection"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "@type": graphTypeValues.reverse[type],
    "@id": id,
    "name": name == null ? null : name,
    "url": url == null ? null : url,
    "sameAs": sameAs == null ? null : List<dynamic>.from(sameAs.map((x) => x)),
    "logo": logo == null ? null : logo.toJson(),
    "image": image == null ? null : image.toJson(),
    "description": description == null ? null : description,
    "publisher": publisher == null ? null : publisher.toJson(),
    "potentialAction": potentialAction == null ? null : List<dynamic>.from(potentialAction.map((x) => x.toJson())),
    "inLanguage": inLanguage == null ? null : inLanguageValues.reverse[inLanguage],
    "contentUrl": contentUrl == null ? null : contentUrl,
    "width": width == null ? null : width,
    "height": height == null ? null : height,
    "caption": caption == null ? null : caption,
    "isPartOf": isPartOf == null ? null : isPartOf.toJson(),
    "primaryImageOfPage": primaryImageOfPage == null ? null : primaryImageOfPage.toJson(),
    "datePublished": datePublished == null ? null : datePublished.toIso8601String(),
    "dateModified": dateModified == null ? null : dateModified.toIso8601String(),
    "breadcrumb": breadcrumb == null ? null : breadcrumb.toJson(),
    "itemListElement": itemListElement == null ? null : List<dynamic>.from(itemListElement.map((x) => x.toJson())),
    "author": author == null ? null : author.toJson(),
    "headline": headline == null ? null : headline,
    "mainEntityOfPage": mainEntityOfPage == null ? null : mainEntityOfPage.toJson(),
    "wordCount": wordCount == null ? null : wordCount,
    "thumbnailUrl": thumbnailUrl == null ? null : thumbnailUrl,
    "keywords": keywords == null ? null : List<dynamic>.from(keywords.map((x) => x)),
    "articleSection": articleSection == null ? null : List<dynamic>.from(articleSection.map((x) => x)),
  };
}

class BreadcrumbClass {
  BreadcrumbClass({
    this.id,
  });

  String id;

  factory BreadcrumbClass.fromJson(Map<String, dynamic> json) => BreadcrumbClass(
    id: json["@id"],
  );

  Map<String, dynamic> toJson() => {
    "@id": id,
  };
}

class Image {
  Image({
    this.id,
    this.type,
    this.inLanguage,
    this.url,
    this.contentUrl,
    this.caption,
    this.width,
    this.height,
  });

  String id;
  GraphType type;
  InLanguage inLanguage;
  String url;
  String contentUrl;
  String caption;
  int width;
  int height;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["@id"],
    type: json["@type"] == null ? null : graphTypeValues.map[json["@type"]],
    inLanguage: json["inLanguage"] == null ? null : inLanguageValues.map[json["inLanguage"]],
    url: json["url"] == null ? null : json["url"],
    contentUrl: json["contentUrl"] == null ? null : json["contentUrl"],
    caption: json["caption"] == null ? null : json["caption"],
    width: json["width"] == null ? null : json["width"],
    height: json["height"] == null ? null : json["height"],
  );

  Map<String, dynamic> toJson() => {
    "@id": id,
    "@type": type == null ? null : graphTypeValues.reverse[type],
    "inLanguage": inLanguage == null ? null : inLanguageValues.reverse[inLanguage],
    "url": url == null ? null : url,
    "contentUrl": contentUrl == null ? null : contentUrl,
    "caption": caption == null ? null : caption,
    "width": width == null ? null : width,
    "height": height == null ? null : height,
  };
}

enum InLanguage { EN_US }

final inLanguageValues = EnumValues({
  "en-US": InLanguage.EN_US
});

enum GraphType { ORGANIZATION, WEB_SITE, IMAGE_OBJECT, WEB_PAGE, BREADCRUMB_LIST, NEWS_ARTICLE, PERSON }

final graphTypeValues = EnumValues({
  "BreadcrumbList": GraphType.BREADCRUMB_LIST,
  "ImageObject": GraphType.IMAGE_OBJECT,
  "NewsArticle": GraphType.NEWS_ARTICLE,
  "Organization": GraphType.ORGANIZATION,
  "Person": GraphType.PERSON,
  "WebPage": GraphType.WEB_PAGE,
  "WebSite": GraphType.WEB_SITE
});

class ItemListElement {
  ItemListElement({
    this.type,
    this.position,
    this.name,
    this.item,
  });

  ItemListElementType type;
  int position;
  String name;
  String item;

  factory ItemListElement.fromJson(Map<String, dynamic> json) => ItemListElement(
    type: itemListElementTypeValues.map[json["@type"]],
    position: json["position"],
    name: json["name"],
    item: json["item"] == null ? null : json["item"],
  );

  Map<String, dynamic> toJson() => {
    "@type": itemListElementTypeValues.reverse[type],
    "position": position,
    "name": name,
    "item": item == null ? null : item,
  };
}

enum ItemListElementType { LIST_ITEM }

final itemListElementTypeValues = EnumValues({
  "ListItem": ItemListElementType.LIST_ITEM
});

class PotentialAction {
  PotentialAction({
    this.type,
    this.target,
    this.queryInput,
  });

  PotentialActionType type;
  dynamic target;
  QueryInput queryInput;

  factory PotentialAction.fromJson(Map<String, dynamic> json) => PotentialAction(
    type: potentialActionTypeValues.map[json["@type"]],
    target: json["target"],
    queryInput: json["query-input"] == null ? null : queryInputValues.map[json["query-input"]],
  );

  Map<String, dynamic> toJson() => {
    "@type": potentialActionTypeValues.reverse[type],
    "target": target,
    "query-input": queryInput == null ? null : queryInputValues.reverse[queryInput],
  };
}

enum QueryInput { REQUIRED_NAME_SEARCH_TERM_STRING }

final queryInputValues = EnumValues({
  "required name=search_term_string": QueryInput.REQUIRED_NAME_SEARCH_TERM_STRING
});

class TargetClass {
  TargetClass({
    this.type,
    this.urlTemplate,
  });

  TargetType type;
  UrlTemplate urlTemplate;

  factory TargetClass.fromJson(Map<String, dynamic> json) => TargetClass(
    type: targetTypeValues.map[json["@type"]],
    urlTemplate: urlTemplateValues.map[json["urlTemplate"]],
  );

  Map<String, dynamic> toJson() => {
    "@type": targetTypeValues.reverse[type],
    "urlTemplate": urlTemplateValues.reverse[urlTemplate],
  };
}

enum TargetType { ENTRY_POINT }

final targetTypeValues = EnumValues({
  "EntryPoint": TargetType.ENTRY_POINT
});

enum UrlTemplate { HTTPS_WWW_NEWSBTC_COM_S_SEARCH_TERM_STRING }

final urlTemplateValues = EnumValues({
  "https://www.newsbtc.com/?s={search_term_string}": UrlTemplate.HTTPS_WWW_NEWSBTC_COM_S_SEARCH_TERM_STRING
});

enum PotentialActionType { SEARCH_ACTION, READ_ACTION }

final potentialActionTypeValues = EnumValues({
  "ReadAction": PotentialActionType.READ_ACTION,
  "SearchAction": PotentialActionType.SEARCH_ACTION
});

enum TwitterCard { SUMMARY_LARGE_IMAGE }

final twitterCardValues = EnumValues({
  "summary_large_image": TwitterCard.SUMMARY_LARGE_IMAGE
});

enum Twitter { NEWSBTC, TWITTER_COM_AAYUSH_JS }

final twitterValues = EnumValues({
  "@newsbtc": Twitter.NEWSBTC,
  "@twitter.com/AayushJs": Twitter.TWITTER_COM_AAYUSH_JS
});

class TwitterMisc {
  TwitterMisc({
    this.writtenBy,
    this.estReadingTime,
  });

  String writtenBy;
  String estReadingTime;

  factory TwitterMisc.fromJson(Map<String, dynamic> json) => TwitterMisc(
    writtenBy: json["Written by"],
    estReadingTime: json["Est. reading time"],
  );

  Map<String, dynamic> toJson() => {
    "Written by": writtenBy,
    "Est. reading time": estReadingTime,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
