Marionette = require 'backbone.marionette'

module.exports = class ChangeView extends Marionette.ItemView
    template: (data) ->
        """
        Change: $#{data.change}
        """

    tagName: 'button'

    modelEvents:
        'change:change': 'render'
