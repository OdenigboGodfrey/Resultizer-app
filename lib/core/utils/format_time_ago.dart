String formatTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inMinutes < 1) {
    return "Just now";
  } else if (difference.inHours < 1) {
    final minutes = difference.inMinutes;
    return "$minutes minute${minutes == 1 ? '' : 's'} ago";
  } else if (difference.inDays < 1) {
    final hours = difference.inHours;
    return "$hours hour${hours == 1 ? '' : 's'} ago";
  } else if (difference.inDays == 1) {
    return "1 day ago";
  } else {
    final days = difference.inDays;
    return "$days day${days == 1 ? '' : 's'} ago";
  }
}