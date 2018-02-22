###* @babel ###
import uri from './uri'
import { compile } from 'coffeescript'

export default class ActiveEditorInfoView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('atom-darklite')

    # Create message element
    @message = message = document.createElement('div')
    message.classList.add('message')
    @element.appendChild message

    # Update Content -- CoffeeTranspiler
    @subscriptions = []
    @subscriptions[0] = atom.workspace.onDidChangeActiveTextEditor (@editor) =>
      @subscriptions[1]?.dispose()
      if not @editor? then return

      @subscriptions[1] = @editor.onDidChange =>
        sectionsToCompile = []

        # if no selection, check scope for the whole file, then select all.
        scopes = @editor.getRootScopeDescriptor().getScopesArray()
        if @scopeIsCoffee(scopes)
          section = @editor.getText()

          try
            compiledSection = compile section, @compilerOptions
            if !compiledSection.trim()
              message.innerText = '// There is nothing to compile'
            else
              @showResult compiledSection
          catch error
            @showError error

  scopeIsCoffee: (scopes) ->
    checkScope = (scope)->
      scope is 'source.litcoffee' or
      scope is 'source.coffee'
    scopes.findIndex(checkScope) > -1

  showError: (error)->
    @message.innerHTML = """
      CoffeeScript Error!
      <big>#{error.name}:#{error.message}</big>
      #{error.code}
    """

  showResult: (content)->
    contentElement = document.createElement('code')
    contentElement.innerText = content
    button = document.createElement('button')
    button.innerText = 'Copy to clipboard'
    button.addEventListener 'click', -> atom.clipboard.write content
    @message.appendChild contentElement
    @message.appendChild button

  # Returns an object that can be retrieved when package is activated
  serialize: ->
    deserializer: 'atom-darklite/CoffeeTranspiler'

  # Tear down any state and detach
  destroy: ->
    @element.remove()
    for sub in @subscriptions
      sub.dispose()

  getTitle: -> 'Coffee Transpiled'

  getURI: -> uri

  getDefaultLocation: -> 'bottom'

  getElement: ->
    @element
