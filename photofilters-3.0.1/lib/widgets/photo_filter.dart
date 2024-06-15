import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as imageLib;
import 'package:path_provider/path_provider.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:get/get.dart';


class PhotoFilter extends StatelessWidget {
  final imageLib.Image image;
  final String filename;
  final Filter filter;
  final BoxFit fit;
  final Widget loader;

  PhotoFilter({
    required this.image,
    required this.filename,
    required this.filter,
    this.fit = BoxFit.fill,
    this.loader = const Center(child: CircularProgressIndicator(strokeWidth: 1.0, color: Colors.redAccent,)),
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
      future: compute(
          applyFilter,
          <String, dynamic>{
            "filter": filter,
            "image": image,
            "filename": filename,
          }),
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return loader;
          case ConnectionState.active:
          case ConnectionState.waiting:
            return loader;
          case ConnectionState.done:
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            return Image.memory(
              snapshot.data as dynamic,
              fit: fit,
            );
        }
      },
    );
  }
}
///The PhotoFilterSelector Widget for apply filter from a selected set of filters
class PhotoFilterSelector extends StatefulWidget {
  // final Widget title;
  // final Color appBarColor;
  final Widget customAppBar;
  final List<Filter> filters;
  final imageLib.Image image;
  final Widget loader;
  final BoxFit fit;
  final String filename;
  final bool isFilter;

  const PhotoFilterSelector({
    Key? key,
    // required this.title,
    required this.filters,
    required this.image,
    // this.appBarColor = Colors.blue,
    this.loader = const Center(child: CircularProgressIndicator()),
    this.fit = BoxFit.fill,
    required this.filename,
    this.isFilter = false,
    required this.customAppBar,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _PhotoFilterSelectorState();
}
// builder image be wrap with filter, this variable identify which filter is apply, help store state when change tool
int indexFilter = 0;

class _PhotoFilterSelectorState extends State<PhotoFilterSelector> {
  String? filename;
  Map<String, List<int>?> cachedFilters = {};
  Filter? _filter;
  imageLib.Image? image;
  late bool loading;
  bool showFilter = false;

  @override
  void initState() {
    super.initState();
    loading = false;
    _filter = widget.filters[0];
    filename = widget.filename;
    image = widget.image;
    showFilter = widget.isFilter;
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white,),
        centerTitle: true,
        title: Text('Filters', style: TextStyle(color : Colors.white),),
        backgroundColor: Colors.white12,
        leading: IconButton(
          onPressed: () {Get.back();},
          icon: Icon(Icons.arrow_back_ios_outlined),),
        actions: <Widget>[
          loading
              ? Container()
              : IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    var imageFile = await saveFilteredImage();
                    Get.back(result: {'image_filtered': imageFile});
                  },
                )
        ],
      ),
      body: Container(
        color: Colors.black45,
        width: double.infinity,
        height: double.infinity,
        child: loading
            ? widget.loader
            : Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Flexible(
                  //     child: Container(
                  //       height: 50,
                  //       child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.end,
                  //       children: [
                  //       IconButton(
                  //         onPressed: () {},
                  //         icon: Icon(Icons.compare_outlined),
                  //         color: Color(0xFF97979D),
                  //         highlightColor: Colors.transparent,
                  //       )
                  //                           ],
                  //                         ),
                  //     )),
                  Expanded(
                    flex: 9,
                    child:  _buildFilteredImage(
                      _filter,
                      image,
                      filename,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Visibility(
                      visible: showFilter,
                      child: Container(
                        color: Colors.white12,
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.filters.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              splashColor: Colors.transparent,
                              child: Container(
                                padding: EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    _buildFilterThumbnail(
                                        widget.filters[index], image, filename),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      widget.filters[index].name,
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () => setState(() {
                                _filter = widget.filters[index];
                              }),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
  _buildFilterThumbnail(
      Filter filter, imageLib.Image? image, String? filename) {
    if (cachedFilters[filter.name] == null) {
      return FutureBuilder<List<int>>(
        future: compute(
            applyFilter ,
            <String, dynamic>{
              "filter": filter,
              "image": image,
              "filename": filename,
            }),
        builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Container(
                height: 80,
                width: 60,
                color: Color(0xFF141414),
                child: Center(
                  child: widget.loader,
                ),
              );
            case ConnectionState.done:
              if (snapshot.hasError)
                return Center(child: Text('Error: ${snapshot.error}'));
              cachedFilters[filter.name] = snapshot.data;
                return Container(
                height: 80,
                width: 60,
              decoration: BoxDecoration(image: DecorationImage(image: MemoryImage(snapshot.data as dynamic), fit: BoxFit.cover ) ),
              );
          }
          // unreachable
        },
      );
    } else {
      return Container(
        height:  80,
        width: 60,
        decoration: BoxDecoration(image: DecorationImage(image: MemoryImage(cachedFilters[filter.name] as dynamic), fit: BoxFit.cover ) ),
      );
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    // return File('$path/filtered_${_filter?.name ?? "_"}_$filename');
    return File('$path/f_$filename');
    // return File('$path/edit.jpg');
  }

  Future<File> saveFilteredImage() async {
    var imageFile = await _localFile;
    await imageFile.writeAsBytes(cachedFilters[_filter?.name ?? "_"]!);
    return imageFile;
  }



  Widget _buildFilteredImage(
      Filter? filter, imageLib.Image? image, String? filename) {
    if (cachedFilters[filter?.name ?? "_"] == null) {
      return FutureBuilder<List<int>>(
        future: compute(
            applyFilter,
            <String, dynamic>{
              "filter": filter,
              "image": image,
              "filename": filename,
            }
          ),
        builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return widget.loader;
            case ConnectionState.active:
            case ConnectionState.waiting:
              return widget.loader;
            case ConnectionState.done:
              if (snapshot.hasError)
                return Center(child: Text('Error: ${snapshot.error}'));
              cachedFilters[filter?.name ?? "_"] = snapshot.data;
              return Image.memory(
                      snapshot.data as dynamic,
                      fit: BoxFit.fitWidth,
                      filterQuality: FilterQuality.high,
                    );
          }
          // unreachable
        },
      );
    } else {
      return Image.memory(
              cachedFilters[filter?.name ?? "_"] as dynamic,
              fit: widget.fit,
            );
    }
  }
}
///The global apply filter function
FutureOr<List<int>> applyFilter(Map<String, dynamic> params) {
  Filter? filter = params["filter"];
  imageLib.Image image = params["image"];
  String filename = params["filename"];
  List<int> _bytes = image.getBytes();
  if (filter != null) {
    filter.apply(_bytes as dynamic, image.width, image.height);
  }
  imageLib.Image _image =
      imageLib.Image.fromBytes(image.width, image.height, _bytes);
  _bytes = imageLib.encodeNamedImage(_image, filename)!;

  return _bytes;
}
///The global buildThumbnail function
FutureOr<List<int>> buildThumbnail(Map<String, dynamic> params) {
  int? width = params["width"];
  params["image"] = imageLib.copyResize(params["image"], width: width);
  return applyFilter(params);
}
