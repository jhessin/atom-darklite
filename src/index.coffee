###* @babel ###


import { CompositeDisposable, Disposable } from 'atom'
import figlet from 'figlet'
import uri from './uri'
import ActiveEditorInfoView from './ActiveEditorInfoView'

export default AtomDarklite =
  subscriptions: null

  activate: (state) ->

    # Events subscribed to in atom's system can be
    # easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable(
      atom.workspace.addOpener (req) ->
        if req is uri
          new ActiveEditorInfoView()
    )

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace',
    'atom-darklite:convert': => @convert()
    @subscriptions.add atom.commands.add 'atom-workspace',
      'atom-darklite:toggle': => @toggle()

    # Destroy any ActiveEditorInfoViews when the package is deactivated
    new Disposable ->
      atom.workspace.getPaneItems().forEach (item) ->
        item.destroy() if item instanceof 'ActiveEditorInfoView'

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomDarkliteView.destroy()

  deserializeActiveEditorInfoView: (serialized) ->
    new ActiveEditorInfoView()

  convert: ->
    editor = atom.workspace.getActiveTextEditor()
    selection = editor?.getSelectedText()
    font = 'o8'
    figlet selection, { font }, (error, art)->
      if error
        console.error error
      else
        editor?.insertText "\n#{art}\n"

  toggle: ->
    atom.workspace.toggle(uri)
