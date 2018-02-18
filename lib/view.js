/** @babel */
var AtomDarkliteView;

export default AtomDarkliteView = class AtomDarkliteView {
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
  }

  // Returns an object that can be retrieved when package is activated
  serialize() {}

  // Tear down any state and detach
  destroy() {
    return this.element.remove();
  }

  setCount(count) {
    return this.element.children[0].textContent = `There are ${count} words.`;
  }

  getElement() {
    return this.element;
  }

};
