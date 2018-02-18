/** @babel */
var AtomDarklite;

import {
  /*

  oooo     oooo           o888
   88   88  88 ooooooooo8  888   ooooooo     ooooooo  oo ooo oooo   ooooooooo8
    88 888 88 888oooooo8   888 888     888 888     888 888 888 888 888oooooo8
     888 888  888          888 888         888     888 888 888 888 888
      8   8     88oooo888 o888o  88ooo888    88ooo88  o888o888o888o  88oooo888

  */
  CompositeDisposable
} from 'atom';

import figlet from 'figlet';

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
    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'atom-darklite:toggle': () => {
        return this.toggle();
      }
    }));
    return this.subscriptions.add(atom.commands.add('atom-workspace', {
      'atom-darklite:convert': () => {
        return this.convert();
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
  convert: function() {
    var editor, font, selection;
    editor = atom.workspace.getActiveTextEditor();
    selection = editor != null ? editor.getSelectedText() : void 0;
    font = 'o8';
    return figlet(selection, {font}, function(error, art) {
      if (error) {
        return console.error(error);
      } else {
        return editor != null ? editor.insertText(`\n${art}\n`) : void 0;
      }
    });
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
