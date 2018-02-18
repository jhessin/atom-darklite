###* @babel ###

###

oooo     oooo           o888
 88   88  88 ooooooooo8  888   ooooooo     ooooooo  oo ooo oooo   ooooooooo8
  88 888 88 888oooooo8   888 888     888 888     888 888 888 888 888oooooo8
   888 888  888          888 888         888     888 888 888 888 888
    8   8     88oooo888 o888o  88ooo888    88ooo88  o888o888o888o  88oooo888

###

import { CompositeDisposable } from 'atom'
import figlet from 'figlet'
import AtomDarkliteView from './view'

export default AtomDarklite =
  atomDarkliteView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomDarkliteView = new AtomDarkliteView(state.atomDarkliteViewState)
    @modalPanel = atom.workspace.addModalPanel
      item: @atomDarkliteView.getElement()
      visible: false

    # Events subscribed to in atom's system can be
    # easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable()

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace',
      'atom-darklite:toggle': => @toggle()
    @subscriptions.add atom.commands.add 'atom-workspace',
      'atom-darklite:convert': => @convert()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomDarkliteView.destroy()

  serialize: ->
    atomDarkliteViewState: @atomDarkliteView.serialize()

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
    console.log 'AtomDarklite was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      editor = atom.workspace.getActiveTextEditor()
      words = editor?.getText().split(/\s+/).length
      @atomDarkliteView.setCount(words)
      @modalPanel.show()
