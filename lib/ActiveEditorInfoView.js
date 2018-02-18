/** @babel */
var ActiveEditorInfoView;

import uri from './uri';

export default ActiveEditorInfoView = class ActiveEditorInfoView {
  constructor(serializedState) {
    var message;
    // Create root element
    this.element = document.createElement('div');
    this.element.classList.add('atom-darklite');
    // Create message element
    message = document.createElement('div');
    message.textContent = "The AtomDarklite package is Alive! It's ALIVE!";
    message.classList.add('message');
    this.element.appendChild(message);
    // Update content
    this.subscriptions = atom.workspace.getCenter().observeActivePaneItem(function(item) {
      var ref;
      if (!atom.workspace.isTextEditor(item)) {
        return message.innerText = 'Open a file to see important information about it.';
      } else {
        return message.innerHTML = `<h2>${(ref = item.getFileName()) != null ? ref : 'untitled'}</h2> <ul> <li><b>Soft Wrap:</b> ${item.softWrapped}</li> <li><b>Tab Length:</b> ${item.getTabLength()}</li> <li><b>Encoding:</b> ${item.getEncoding()}</li> <li><b>Line Count:</b> ${item.getLineCount()}</li> </ul>`;
      }
    });
  }

  // Returns an object that can be retrieved when package is activated
  serialize() {
    return {
      deserializer: 'atom-darklite/ActiveEditorInfoView'
    };
  }

  // Tear down any state and detach
  destroy() {
    this.element.remove();
    return this.subscriptions.dispose();
  }

  getTitle() {
    return 'Active Editor Info';
  }

  getURI() {
    return uri;
  }

  getDefaultLocation() {
    return 'right';
  }

  getAllowedLocations() {
    return ['left', 'right', 'bottom'];
  }

  getElement() {
    return this.element;
  }

};
