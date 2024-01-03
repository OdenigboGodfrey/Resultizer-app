String getInitials(String name) {
  List<String> nameParts = name.split(' ');
  String initials = '';

  // Iterate through name parts and extract initials
  nameParts.forEach((part) {
    if (part.isNotEmpty) {
      initials += '${part[0].toUpperCase()}.';
    }
  });

  return initials.substring(0, initials.length - 1); // Remove trailing comma
}
