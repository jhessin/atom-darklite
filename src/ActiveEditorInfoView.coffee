###* @babel ###
import uri from './uri'
export default class ActiveEditorInfoView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('atom-darklite')

    # Create message element
    message = document.createElement('div')
    message.textContent = "The AtomDarklite package is Alive! It's ALIVE!"
    message.classList.add('message')
    @element.appendChild(message)

    # Update content
    @subscriptions = atom.workspace.getCenter()
    .observeActivePaneItem (item)->
      if not atom.workspace.isTextEditor(item)
        message.innerText = 'Open a file to see important information about it.'
      else
        message.innerHTML = "
          <h2>#{item.getFileName() ? 'untitled'}</h2>
          <ul>
            <li><b>Soft Wrap:</b> #{item.softWrapped}</li>
            <li><b>Tab Length:</b> #{item.getTabLength()}</li>
            <li><b>Encoding:</b> #{item.getEncoding()}</li>
            <li><b>Line Count:</b> #{item.getLineCount()}</li>
          </ul>
        "

  # Returns an object that can be retrieved when package is activated
  serialize: ->
    deserializer: 'atom-darklite/ActiveEditorInfoView'

  # Tear down any state and detach
  destroy: ->
    @element.remove()
    @subscriptions.dispose()

  getTitle: -> 'Active Editor Info'

  getURI: -> uri

  getDefaultLocation: -> 'right'

  getAllowedLocations: -> ['left', 'right', 'bottom']

  getElement: ->
    @element
