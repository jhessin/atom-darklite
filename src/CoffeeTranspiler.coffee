###* @babel ###
import uri from './uri'
import { compile } from 'coffeescript'
import { CompositeDisposable, Disposable } from 'atom'
prettier = require 'prettier'

export default class CoffeeTranspiler

  constructor: ->
    @element = document.createElement('atom-panel')
    @element.classList.add 'atom-darklite'

    editor = document.createElement('atom-text-editor')

    @editor = editor.getModel()
    @editor.setGrammar atom.
    grammars.grammarForScopeName('source.js')
    @element.appendChild editor

    # Update Content -- CoffeeTranspiler
    @subscriptions = new CompositeDisposable()

    @subscribe atom.workspace.getActiveTextEditor()

  subscribe: (editor)=>
    @subscriptions?.dispose()
    if not editor? then return @clear
    @compileCoffee editor
    @subscriptions.add editor.onDidSave =>
      @compileCoffee editor
    @subscriptions.add atom.workspace.onDidChangeActiveTextEditor @subscribe

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

  clear: ->
    @element.write '# Open a coffeescript file to see the
      compiled version here.'

  getTitle: ->
    (atom.workspace.getActiveTextEditor()?.getTitle() ? '') + '(preview)'

  getURI: -> uri

  getElement: -> @element

  getDefaultLocation: -> atom.config.get 'atom-darklite.previewLocation'

  getAllowedLocations: ->
    [ 'left', 'right', 'bottom' ]

  # Tear down any state and detach
  destroy: ->
    @subscriptions?.dispose()
