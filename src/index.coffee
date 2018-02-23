###* @babel ###

import { CompositeDisposable, Disposable } from 'atom'
import uri from './uri'
import CoffeeTranspiler from './CoffeeTranspiler'

export default AtomDarklite =
  subscriptions: null
  config:
    previewLocation:
      type: 'string'
      default: 'right'
      enum: [
        {
          value: 'left',
          description: 'Left'
        }, {
          value: 'right',
          description: 'Right'
        }, {
          value: 'top',
          description: 'Top'
        }, {
          value: 'bottom',
          description: 'Bottom'
        },
      ]

  activate: (state) ->

    # Events subscribed to in atom's system can be
    # easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable(
      atom.workspace.addOpener (req) ->
        if req is uri
          new CoffeeTranspiler()
    )

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace',
      'atom-darklite:toggle': => @toggle()

    # Destroy any CoffeeTranspilers when the package is deactivated
    new Disposable ->
      atom.workspace.getPaneItems().forEach (item) ->
        item.destroy() if item instanceof CoffeeTranspiler

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomDarkliteView.destroy()

  deserializeCoffeeTranspiler: (serialized) ->
    new CoffeeTranspiler()

  toggle: ->
    atom.workspace.toggle(uri)
