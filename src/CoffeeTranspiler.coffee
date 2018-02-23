###* @babel ###
import uri from './uri'
import { compile } from 'coffeescript'
import { CompositeDisposable, Disposable } from 'atom'
prettier = require 'prettier'
# import { registerElement } from 'element-kit'
#
# Template = require('../templates/CodeView.html')
#
# Element = registerElement 'atom-darklite',
#   createdCallback: ->
#     @appendChild Template.clone()
#     @rootTemplate = @querySelector 'template'
#     @classList.add 'atom-darklite'

export default class CoffeeTranspiler

  constructor: ->
    @element = document.createElement('atom-text-editor')
    @editor = @element.getModel()
    @editor.setGrammar atom.
    grammars.grammarForScopeName('source.js')
    # @element.classList.add 'atom-darklite'

    # Update Content -- CoffeeTranspiler
    @activeChangedDisposable =
      new Disposable atom.workspace.onDidChangeActiveTextEditor (editor) =>
        @activeEditorDisposable?.dispose()
        if not editor? then return
        @compileCoffee editor
        @activeEditorDisposable = new Disposable editor.onDidChange =>
          @compileCoffee editor

  compileCoffee: (editor) ->
    if not editor? then return
    scopes = editor.getRootScopeDescriptor().getScopesArray()
    if @scopeIsCoffee(scopes)
      section = editor.getText()

      try
        compiledSection = compile section, @compilerOptions
        if !compiledSection.trim()
          @message.innerText = '// There is nothing to compile'
        else
          @showResult prettier.format compiledSection
      catch error
        @showError error

  scopeIsCoffee: (scopes) ->
    checkScope = (scope)->
      scope is 'source.litcoffee' or
      scope is 'source.coffee'
    scopes.findIndex(checkScope) > -1

  showError: (error)->
    @editor?.setText("CoffeeScript Error!:\n#{error}")

  showResult: (content)->
    @editor?.setText(content)

  getTitle: ->
    (atom.workspace.getActiveTextEditor()?.getTitle() ? '') + '(preview)'

  getURI: -> uri

  getElement: -> @element

  getDefaultLocation: -> atom.config.get 'atom-darklite.previewLocation'

  # Tear down any state and detach
  destroy: ->
    @activeChangedDisposable?.dispose()
    @activeEditorDisposable?.dispose()
