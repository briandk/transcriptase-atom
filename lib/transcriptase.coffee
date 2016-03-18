TranscriptaseView = require './transcriptase-view'
{CompositeDisposable} = require 'atom'

module.exports = Transcriptase =
  transcriptaseView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @transcriptaseView = new TranscriptaseView(state.transcriptaseViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @transcriptaseView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'transcriptase:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @transcriptaseView.destroy()

  serialize: ->
    transcriptaseViewState: @transcriptaseView.serialize()

  toggle: ->
    console.log 'Transcriptase was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
