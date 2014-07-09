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
        { amount: 0.5 }
        { amount: 0.10 }
        { amount: 0.25 }
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



