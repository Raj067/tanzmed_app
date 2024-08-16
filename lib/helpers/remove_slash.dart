String removeDoubleSlash(String name) {
  if (name.startsWith('//')) {
    return "https:$name"; // Remove the first two characters
  } else {
    return name;
  }
}