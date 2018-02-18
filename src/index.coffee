###* @babel ###

AtomDarkliteView = require './view'
{ CompositeDisposable } = require 'atom'

module.exports = AtomDarklite =
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
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace',
      'atom-darklite:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomDarkliteView.destroy()

  serialize: ->
    atomDarkliteViewState: @atomDarkliteView.serialize()

  toggle: ->
    console.log 'AtomDarklite was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      editor = atom.workspace.getActiveTextEditor()
      words = editor?.getText().split(/\s+/).length
      @atomDarkliteView.setCount(words)
      @modalPanel.show()
