//require jquery

RushHour = {}
RushHour.track = function(clientName, eventName) {
  // some stuff to get information
  data = {
    "url": window.location.origin + window.location.pathname,
    "requestedAt": (new Date()).toISOString(),
    //"responseTime":unc,
    "requestType": "GET",
    "parameters": window.location.search.replace("?","").split("&"),
    "eventName": eventName,
    "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    "resolutionWidth":"1920",
    "resolutionHeight":"1280",
    "ip":"63.29.38.211"
  }
  console.log(data);
  /*$.ajax({
    url: "",
    data: {

    },
    method: "POST",
    success: function(){},
    error: function(){},
  })*/
};
