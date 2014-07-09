Marionette = require 'backbone.marionette'

class CoinView extends Marionette.ItemView
    template: (data) ->
        """
        $#{data.amount}
        """

    tagName: 'button'

    triggers:
        'click': 'deposit'



module.exports = class CoinList extends Marionette.CompositeView
    childView: CoinView
    childViewContainer: '.js-stuff'

    template: (data) ->
        """
        Total Deposited: $#{data.pending}
        <div class="js-stuff"></div>
        """

    modelEvents:
        'change:pending': 'render'

    childEvents:
        'deposit': (view, { model } )->
            @trigger 'change:state', 'onDeposit', model.get('amount')
