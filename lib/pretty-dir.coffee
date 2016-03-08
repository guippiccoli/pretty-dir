PrettyDirView = require './pretty-dir-view'
{CompositeDisposable} = require 'atom'

module.exports = PrettyDir =
  prettyDirView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @prettyDirView = new PrettyDirView(state.prettyDirViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @prettyDirView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'pretty-dir:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @prettyDirView.destroy()

  serialize: ->
    prettyDirViewState: @prettyDirView.serialize()

  toggle: ->
    console.log 'PrettyDir was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
