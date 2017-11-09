#= require moment.min.js

class Dashing.Omnipollo extends Dashing.Widget
  onData: (data) ->
    updated = data.updated.split('Last updated:')[1] || ''
    date = moment(updated, ' hh:mm dddd MMMM Do YYYY');
    date.locale('sv')

    @set("update_time", date.format('hh:mm'))