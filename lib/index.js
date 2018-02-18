/** @babel */
var AtomDarklite;

import {
  CompositeDisposable
} from 'atom';

import AtomDarkliteView from './view';

export default AtomDarklite = {
  atomDarkliteView: null,
  modalPanel: null,
  subscriptions: null,
  activate: function(state) {
    this.atomDarkliteView = new AtomDarkliteView(state.atomDarkliteViewState);
    this.modalPanel = atom.workspace.addModalPanel({
      item: this.atomDarkliteView.getElement(),
      visible: false
    });
    // Events subscribed to in atom's system can be
    // easily cleaned up with a CompositeDisposable
    this.subscriptions = new CompositeDisposable();
    // Register command that toggles this view
    return this.subscriptions.add(atom.commands.add('atom-workspace', {
      'atom-darklite:toggle': () => {
        return this.toggle();
      }
    }));
  },
  deactivate: function() {
    this.modalPanel.destroy();
    this.subscriptions.dispose();
    return this.atomDarkliteView.destroy();
  },
  serialize: function() {
    return {
      atomDarkliteViewState: this.atomDarkliteView.serialize()
    };
  },
  toggle: function() {
    var editor, words;
    console.log('AtomDarklite was toggled!');
    if (this.modalPanel.isVisible()) {
      return this.modalPanel.hide();
    } else {
      editor = atom.workspace.getActiveTextEditor();
      words = editor != null ? editor.getText().split(/\s+/).length : void 0;
      this.atomDarkliteView.setCount(words);
      return this.modalPanel.show();
    }
  }
};
