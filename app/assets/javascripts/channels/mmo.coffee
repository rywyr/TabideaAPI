App.mmo = App.cable.subscriptions.create "MmoChannel",
  connected: ->

  disconnected: ->


  received: (data) ->
    
    
  create: ->
    @perform 'create'
