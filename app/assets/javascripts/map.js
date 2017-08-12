function initMap() {
    var map = new google.maps.Map(document.getElementById('map'), {
      mapTypeControl: false,
      center: {lat: 17.3850, lng: 78.4867},

      zoom: 15
    });

    new AutocompleteDirectionsHandler(map);
  }

  function AutocompleteDirectionsHandler(map) {
    this.map = map;
    this.originPlaceId = null;
    this.destinationPlaceId = null;
    this.travelMode = 'WALKING';
    var originInput = document.getElementById('txtSource');
    var secondoriginInput = document.getElementById('secondtxtSource');
    var destinationInput = document.getElementById('txtDestination');
    var seconddestinationInput = document.getElementById('secondtxtDestination');

        // var modeSelector = document.getElementById('mode-selector');
        this.directionsService = new google.maps.DirectionsService;
        this.directionsDisplay = new google.maps.DirectionsRenderer;
        this.directionsDisplay.setMap(map);

        var originAutocomplete = new google.maps.places.Autocomplete(
          originInput, {placeIdOnly: true});
        var secondoriginAutocomplete = new google.maps.places.Autocomplete(
          secondoriginInput, {placeIdOnly: true});
        var destinationAutocomplete = new google.maps.places.Autocomplete(
          destinationInput, {placeIdOnly: true});
        var seconddestinationAutocomplete = new google.maps.places.Autocomplete(
          seconddestinationInput, {placeIdOnly: true});        

        this.setupClickListener('changemode-walking', 'WALKING');
        this.setupClickListener('changemode-transit', 'DRIVING');
        
        
        
        this.setupPlaceChangedListener(originAutocomplete, 'ORIG');
        this.setupPlaceChangedListener(destinationAutocomplete, 'DEST');

        this.setupPlaceChangedListener(secondoriginAutocomplete, 'ORIG');
        this.setupPlaceChangedListener(seconddestinationAutocomplete, 'DEST');

      }

      AutocompleteDirectionsHandler.prototype.setupClickListener = function(id, mode) {
        var radioButton = document.getElementById(id);
        var me = this;
        if (radioButton!=undefined){
          radioButton.addEventListener('click', function() {
            me.travelMode = mode;
            me.route();
          });
        }
      };

      AutocompleteDirectionsHandler.prototype.setupPlaceChangedListener = function(autocomplete, mode) {
        var me = this;
        autocomplete.bindTo('bounds', this.map);
        autocomplete.addListener('place_changed', function() {
          var place = autocomplete.getPlace();
          if (!place.place_id) {
            window.alert("Please select an option from the dropdown list.");
            return;
          }
          if (mode === 'ORIG') {
            me.originPlaceId = place.place_id;
          } else {
            me.destinationPlaceId = place.place_id;
          }
          me.route();
        });

      };

      AutocompleteDirectionsHandler.prototype.route = function() {
        if (!this.originPlaceId || !this.destinationPlaceId) {
          return;
        }
        var me = this;

        this.directionsService.route({
          origin: {'placeId': this.originPlaceId},
          destination: {'placeId': this.destinationPlaceId},
          travelMode: this.travelMode
        }, function(response, status) {
          if (status === 'OK') {
            me.directionsDisplay.setDirections(response);
          } else {
            window.alert('Directions request failed due to ' + status);
          }
        });
      };
      function GetRoute() {
        var source = $("#SourceValue").val();
        var destination = $("#DestinationValue").val();
    //     source = document.getElementById("txtSource").value;
    // destination = document.getElementById("txtDestination").value;
        $.ajax({
          url: '/search_buses',
          dataType: "script",
          data: {source: source, destination: destination},
        });
      }