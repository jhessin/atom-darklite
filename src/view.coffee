###* @babel ###
export default class AtomDarkliteView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('atom-darklite')

    # Create message element
    message = document.createElement('div')
    message.textContent = "The AtomDarklite package is Alive! It's ALIVE!"
    message.classList.add('message')
    @element.appendChild(message)

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  setCount: (count)->
    @element.children[0].textContent = "There are #{count} words."

  getElement: ->
    @element
