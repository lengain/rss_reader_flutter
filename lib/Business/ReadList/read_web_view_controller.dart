import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rss_reader_flutter/Business/Data/article_item.dart';
import 'package:rss_reader_flutter/Business/navigation_controller.dart';
import 'package:rss_reader_flutter/global/global_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReadWebViewController extends StatefulWidget {
  final ArticleItem articleItem;
  final String? url;

  const ReadWebViewController(this.articleItem, {Key? key, this.url})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ReadWebViewControllerState();
}

class ReadWebViewControllerState extends State<ReadWebViewController> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }


  Widget _webView() {
    return WebView(
      initialUrl: widget.url,
      onWebViewCreated: (WebViewController web) {
        _controller = web;
        if (widget.articleItem.content != null) {
          _controller.loadHtmlString(widget.articleItem.content!);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return navigationViewController(
      _webView(),
      context,
      title: widget.articleItem.title,
      rightBarItem: CupertinoButton(
        padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.compass), onPressed: () async {
          var url = widget.articleItem.articleUrl();
          print("准备打开：$url");
          if ( url != null) {
            if(await canLaunch(url)){
              await launch(url);
            }else{
              GlobalHandler.showToast("无法打开当前文章");
            }
          }else {
            GlobalHandler.showToast("无法打开当前文章");
          }
      }),
    );
  }
}
