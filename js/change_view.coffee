Marionette = require 'backbone.marionette'

module.exports = class ChangeView extends Marionette.ItemView
    template: (data) ->
        """
        <button>Cancel</button>
        Change: <a href="javascript: void 0">$#{data.change}</a>
        """

    tagName: 'button'

    events:
        'click a': ->
            @trigger 'change:state', 'onTakeChange'

        'click button': ->
            @trigger 'change:state', 'onCancel'

    modelEvents:
        'change:change': 'render'
