# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require underscore
#= require gmaps/google


@convert = (objects) ->
  array = []

  for x in objects
    y =
      lat: x.lat
      lng: x.lng
      infowindow: x.name
    array.push y

  googleMap array

@googleMap = (content) ->
  handler = Gmaps.build("Google")
  handler.buildMap
    provider: {}
    internal:
      id: "map"
  , ->
    markers = handler.addMarkers(content)
    handler.bounds.extendWith markers
    handler.fitMapToBounds()


content = [
  {lat: 22.333499, lng: 114.180557,infowindow: "hello!", link: 'a'},
  {lat: 22.263521, lng: 114.1352279,infowindow: "hello!", link: 'b'}
]

$ ->
  $.ajax
    url: '/places.json'
  .done (data) ->
    convert data