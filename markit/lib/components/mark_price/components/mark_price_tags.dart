import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';

import 'package:markit/components/service/notification_service.dart';
import 'package:markit/components/service/tag_service.dart';

class MarkPriceTags extends StatefulWidget {

  final List<String> existingTags;
  final GlobalKey<TagsState> tagStateKey;

  MarkPriceTags({Key key, this.existingTags, this.tagStateKey}) : super(key: key);

  @override
  MarkPriceTagsState createState() => MarkPriceTagsState();
}

class MarkPriceTagsState extends State<MarkPriceTags> {

  NotificationService notificationService = new NotificationService();
  TagService tagService = new TagService();

  String tagSearchQuery = '';
  List<String> suggestions = [];
  List<Item> tags;

  bool tagsUpdated = false;

  @override
  void initState() {
    super.initState();
    if (!tagsUpdated) {
      tags = createTagsFromList(widget.existingTags);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Tags(
      key: widget.tagStateKey,
      textField: TagsTextField(
        duplicates: true,
        suggestions: suggestions,
        constraintSuggestion: false,
        textStyle: TextStyle(fontSize: 16, color: Colors.black),
        onChanged: (pattern) async {
          List<String> matches = await getSuggestions(pattern);
          setState(() {
            suggestions = matches;
          });
        },
        onSubmitted: (newTagStr) {
          String tagName = suggestions.firstWhere((suggestion) => suggestion.toLowerCase() == newTagStr.toLowerCase(), orElse: () => null);
          if (tagName != null) {
            newTagStr = tagName;
          }
          if (!tags.map((tag) => tag.title.toLowerCase()).toList().contains(newTagStr.toLowerCase())) {
            tagsUpdated = true;
            setState(() {
              tags.add(Item(
                index: tags.length,
                title: newTagStr,
                active: true,
                customData: true
              ));
            });
          } else {
            notificationService.showErrorNotification('Tag already added.');
          }
        },
      ),
      itemCount: tags.length,
      itemBuilder: (int index) {
        final item = tags[index];
        if (item.customData == true) {
          return ItemTags(
            key: Key(index.toString()),
            index: index,
            title: item.title,
            active: true,
            textStyle: TextStyle(fontSize: 16),
            activeColor: Colors.deepOrange,
            combine: ItemTagsCombine.withTextBefore,
            removeButton: ItemTagsRemoveButton(
              onRemoved: () {
                tagsUpdated = true;
                setState(() {
                  tags.removeAt(index);
                });
                return true;
              }
            ),
            pressEnabled: false,
          );
        } else {
          return ItemTags(
            key: Key(index.toString()),
            index: index,
            title: item.title,
            active: true,
            textStyle: TextStyle(fontSize: 16),
            activeColor: Colors.deepOrange,
            combine: ItemTagsCombine.withTextBefore,
            pressEnabled: false,
          );
        }
      }
    );
  }

  Future<List<String>> getSuggestions(String pattern) async {
    List<Map<String, Object>> response = List<Map<String, Object>>.from(await tagService.getSuggestions(pattern));
    return response.map((suggestion) => suggestion['name'].toString()).toList();
  }

  List<Item> createTagsFromList(List<String> tagsList) {
    List<Item> createdTags = [];
    int ind = 0;
    tagsList.forEach((tag) {
      createdTags.add(
        Item(
          index: ind,
          title: tag,
          active: true,
          customData: false
        )
      );
      ind++;
    });
    return createdTags;
  }
}