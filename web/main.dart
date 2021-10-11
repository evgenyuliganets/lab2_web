import 'dart:html';

void main() {
  var runButton = document.getElementById("run");
  var revertButton = document.getElementById("revert");
  var body = document.body;
  var savedList = List.unmodifiable(body!.children
      .where((element) => element.toString() == "p")
      .map((e) => e.text));

  bool clicked = false;
  (runButton as ButtonElement).onClick.capture((event) {
    if (!clicked) {
      body.children
          .where((parent) => parent.toString() == "p")
          .forEach((element) {
        element.style.color = "green";
        body.insertBefore(
            (element.clone(true) as Element)..style.color = "red", element);
      });
      clicked = true;
    }
  });
  (revertButton as ButtonElement).onClick.capture((event) {
    clicked = false;
    body.children
        .where((element) => element.toString() == "p" || element.tagName == "p")
        .forEach((event) => event.remove());
    body.children.addAll(savedList.map((e) => Element.p()..text = e));
  });
  clicked = false;
}
