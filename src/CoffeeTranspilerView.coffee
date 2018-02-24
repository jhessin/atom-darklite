###* @babel ###
import { View, TextEditorView } from 'atom-space-pen-views'

export default class CoffeeTranspilerView extends View
  @content: ->
    @div =>
      @subview 'editor', new TextEditorView()

  write: (content) ->
    @editor?.getModel().setText(content)
