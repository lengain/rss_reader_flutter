import 'package:intl/intl.dart';
import 'package:webfeed/domain/atom_item.dart';
import 'package:webfeed/domain/atom_person.dart';
import 'package:webfeed/domain/atom_link.dart';
import 'package:webfeed/domain/atom_category.dart';
import 'package:webfeed/domain/atom_source.dart';
import 'package:webfeed/domain/media/media.dart';

extension DateTimeAdd on DateTime {

  String formateString() {
    var time = toString();
    return toString();
  }
}


class ArticleItem extends AtomItem {
  bool isRead = false;
  bool isFavorite = false;

  String? updateTime() {
    if (updated != null) {
      return DateFormat("yyyy-MM-dd HH:mm:ss").format(updated!);
    }else {
      return "未知时间";
    }
  }
  String? articleUrl() {
    for (var link in links!) {
      if (link.rel == "alternate") {
        return link.href;
      }
    }
    return null;
  }

  ArticleItem(
      this.isRead,
      this.isFavorite,
      {
        String? id,
        String? title,
        DateTime? updated,
        List<AtomPerson>? authors,
        List<AtomLink>? links,
        List<AtomCategory>? categories,
        List<AtomPerson>? contributors,
        AtomSource? source,
        String? published,
        String? content,
        String? summary,
        String? rights,
        Media? media,
      }
  ) : super(
    id: id,
    title: title,
    updated: updated,
    authors: authors,
    links: links,
    categories: categories,
    contributors: contributors,
    source: source,
    published: published,
    content: content,
    summary: summary,
    rights: rights,
    media: media,
  );

  ArticleItem.fromAtomItem(AtomItem item) : isRead = false,isFavorite = false,super(
    id: item.id,
    title: item.title,
    updated: item.updated,
    authors: item.authors,
    links: item.links,
    categories: item.categories,
    contributors: item.contributors,
    source: item.source,
    published: item.published,
    content: item.content,
    summary: item.summary,
    rights: item.rights,
    media: item.media,
  );
}