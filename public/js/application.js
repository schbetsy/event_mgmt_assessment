var addEventToList = function() {
    var name = $("form #name").val();
    $("#created_events").append("<li>"+name+" (refresh page to access)</li>")
};

var createEvent = function() {
  var name = $("form #name").val();
  var location = $("form #location").val();
  var start = $("form #starts_at").val();
  var end = $("form #ends_at").val();
  var data = {
    "event[name]": name, 
    "event[location]": location, 
    "event[starts_at]": start, 
    "event[ends_at]": end};
  $.post("/event/create", data, function(response){
    console.log(response);
  }),
};


$(document).ready(function(){
  $("#create_event").submit(function(event){
    event.preventDefault();
    addEventToList();
    createEvent();
  });
});
