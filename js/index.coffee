Backbone = require 'backbone'
$ = Backbone.$ = require 'jquery'
Marionette = require 'backbone.marionette'

CoinListView = require './coin_list_view.coffee'
ChangeView = require './change_view.coffee'
ButtonView = require './button_view.coffee'

$ ->

    items = new Backbone.Collection [
        {
            name: 'Mt. Dew'
            qty: 3
            price: .75
        }
        {
            name: 'Pepsi'
            qty: 0
            price: .75
        }
    ]

    mainState = new Backbone.Model
        change: 0
        pending: 0


    coinData = new Backbone.Collection [
        { amount: 0.05 }
        { amount: 0.10 }
        { amount: 0.25 }
        { amount: 0.5 }
        { amount: 1 }
        { amount: 5 }
    ]


    coins = new CoinListView
        collection: coinData
        model: mainState
        el: '#coins'
    coins.render()

    change = new ChangeView
        model: mainState
        el: '#change'
    change.render()

    buttons = new ButtonView
        collection: items
        el: '#buttons'
    buttons.render()

    currentState = 'waiting'

    states =
        waiting:
            onDeposit: (amount) ->
                pending = mainState.get('pending')
                pending += amount
                mainState.set 'pending', pending

                # Everything must have the same price.
                if pending >= .75
                    return 'ready'
                return 'waiting'

            onCancel: ->
                change = mainState.get('change') + mainState.get('pending')

                mainState.set
                    pending: 0
                    change: change

                return 'waiting'

            onTakeChange: ->
                mainState.set 'change', 0
                return 'waiting'

        ready:
            onDeposit: (amount) ->
                change = mainState.get('change') + amount
                mainState.set 'change', change
                return 'ready'

            onSelect: (item) ->
                change = mainState.get('change')
                change += mainState.get('pending') - item.get('price')

                qty = item.get 'qty'

                item.set 'qty', qty - 1

                mainState.set
                    pending: 0
                    change: change

                return 'waiting'

            onCancel: ->
                pending = mainState.get('pending')

                mainState.set
                    pending: 0
                    change: pending

                return 'waiting'
            onTakeChange: ->
                mainState.set 'change', 0
                return 'ready'


    changeState = (eventType, args...) ->
        console.log 'changeState', currentState, arguments...

        unless states[currentState][eventType]?
            console.log 'Invalid event', eventType
            return

        currentState = states[currentState][eventType](args...)

    coins.on 'change:state', changeState
    change.on 'change:state', changeState
    buttons.on 'change:state', changeState

