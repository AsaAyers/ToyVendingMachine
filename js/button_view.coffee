Marionette = require 'backbone.marionette'


class ButtonView extends Marionette.ItemView
    template: (data) ->
        """
        #{data.name} $#{data.price}
        """

    tagName: 'button'

    onRender: ->
        if @model.get('qty') is 0
            @el.disabled = true

    modelEvents:
        'change:qty': 'render'


module.exports = class ButtonCollectionView extends Marionette.CollectionView
    childView: ButtonView

