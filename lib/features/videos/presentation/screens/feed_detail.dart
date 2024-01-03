import 'package:flutter/material.dart';

class FeedDetailView extends StatefulWidget {
  const FeedDetailView({super.key, required this.htmlContent});

  final String htmlContent;

  @override
  State<FeedDetailView> createState() => _FeedDetailViewState();
}

class _FeedDetailViewState extends State<FeedDetailView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(),
      ),
    );
  }
}