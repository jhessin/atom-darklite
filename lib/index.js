/** @babel */
var AtomDarklite;

import {
  CompositeDisposable,
  Disposable
} from 'atom';

import figlet from 'figlet';

import uri from './uri';

import ActiveEditorInfoView from './ActiveEditorInfoView';

export default AtomDarklite = {
  subscriptions: null,
  activate: function(state) {
    // Events subscribed to in atom's system can be
    // easily cleaned up with a CompositeDisposable
    this.subscriptions = new CompositeDisposable(atom.workspace.addOpener(function(req) {
      if (req === uri) {
        return new ActiveEditorInfoView();
      }
    }));
    // Register command that toggles this view
    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'atom-darklite:convert': () => {
        return this.convert();
      }
    }));
    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'atom-darklite:toggle': () => {
        return this.toggle();
      }
    }));
    // Destroy any ActiveEditorInfoViews when the package is deactivated
    return new Disposable(function() {
      return atom.workspace.getPaneItems().forEach(function(item) {
        if (item instanceof 'ActiveEditorInfoView') {
          return item.destroy();
        }
      });
    });
  },
  deactivate: function() {
    this.modalPanel.destroy();
    this.subscriptions.dispose();
    return this.atomDarkliteView.destroy();
  },
  deserializeActiveEditorInfoView: function(serialized) {
    return new ActiveEditorInfoView();
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
    return atom.workspace.toggle(uri);
  }
};
