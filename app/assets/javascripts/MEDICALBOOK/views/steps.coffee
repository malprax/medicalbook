PHYSIALITY.namespace 'Steps', (() ->
  return {
    # take image from camera initial
    initTakePicture: ->
      Webcam.set({
          width: 320,
          height: 240,
          image_format: 'jpeg',
          jpeg_quality: 90
      })

      targetEl = $('[data-camera-take]')

      $.each $(targetEl), (index, value) ->
        Webcam.attach("#" + $(this).attr('id'))

    # taking image from camera
    takePicture: (cameraTake)->
      Webcam.snap (data_uri) ->
        cameraTake = $(cameraTake)
        targetResult = $(cameraTake.data('target-result'))
        targetInput = $(cameraTake.data('target-input'))

        targetInput.val(data_uri)
        console.log(data_uri)
        targetResult.attr('src', data_uri)

    #untake picture
    removeTakePicture: ->
      Webcam.reset()

    wizzardTherapist: ->
      $("#form_step_therapist").steps({
        bodyTag: "fieldset",
        onInit: (event, currentIndex) ->
          # PHYSIALITY.Steps.initTakePicture()


        onStepChanging: (event, currentIndex, newIndex) ->
          form = $(this)

          # Always allow going backward even if the current step contains invalid fields!
          if (currentIndex > newIndex)
            return true

          # Clean up if user went backward before
          if (currentIndex < newIndex)
            # To remove error styles
            $(".body:eq(" + newIndex + ") label.error", form).remove()
            $(".body:eq(" + newIndex + ") .error", form).removeClass("error")

          # Disable validation on fields that are disabled or hidden.
          form.validate().settings.ignore = ":disabled,:hidden"

          # Start validation; Prevent going forward if false
          return form.valid()

        onStepChanged: (event, currentIndex, priorIndex) ->
          # make setup profile always like on if in still sub setup profile
          if(currentIndex == 3 || currentIndex == 4 || currentIndex == 5)
            $('#form-t-2').css({'background': '#1AB394', 'color': '#fff'})
          else
            $('#form-t-2').removeAttr('style')

          # # set to take picture when on this step
          if(currentIndex == 0)
            PHYSIALITY.Steps.initTakePicture()
          else
            PHYSIALITY.Steps.removeTakePicture()

          # set location
          if (currentIndex == 3)
            PHYSIALITY.Steps.getLocation('#maps_wrapper');

        onFinishing: (event, currentIndex) ->
          form = $(this)

          # Disable validation on fields that are disabled.
          # At this point it's recommended to do an overall check (mean ignoring only disabled fields)
          form.validate().settings.ignore = ":disabled"

          return form.valid()

        onFinished: (event, currentIndex) ->
          form = $(this)

          # Submit form input
          form.submit()

        }).validate({
          errorPlacement: (error, element) ->
            element.parent('.form-main-item').after(error)

          rules: {
              confirm: {
                  equalTo: "#password"
              }
          }
        })
      $(document).on 'change', '#travel_radius', ->
        PHYSIALITY.Steps.getLocation('#maps_wrapper')
      $(document).on 'change', '#pull_from_address', ->
        PHYSIALITY.Steps.getLocation('#maps_wrapper')
      $(document).on 'click', '.select_work_day', ->
        $('#working_calendar').multiDatesPicker('resetDates')
        PHYSIALITY.Steps.initCalendar(PHYSIALITY.Steps.get_days_available())

      PHYSIALITY.Steps.uploadFile()
      PHYSIALITY.Steps.timePicker()
      PHYSIALITY.Steps.initCalendar($('#working_calendar').data('dates'));

    uploadFile: ->
      $('.upload_file').on 'change', (evt) ->
        # alert($(this).val());
        id = $(this).data('id')
        tgt = evt.target || window.event.srcElement
        files = tgt.files
        # FileReader support
        if FileReader && files && files.length
          fr = new FileReader()
          fr.onload = ->
            console.log(fr.result)
            document.getElementById('camera_input_' + id).value = fr.result
            document.getElementById('results_' + id).src = fr.result

          fr.readAsDataURL(files[0]);

        # Not supported
        else {
            # fallback -- perhaps submit the input to an iframe and temporarily store
            # them on the server until the user's session ends.
        }

    timePicker: ->
      $('.datepair .morning_time').timepicker({
          'showDuration': false,
          'timeFormat': 'g:ia',
          'minTime': '6:00am',
          'maxTime': '12:00pm'
      })

      $('.datepair .afternoon_time').timepicker({
          'showDuration': false,
          'timeFormat': 'g:ia',
          'minTime': '12:00pm',
          'maxTime': '8:00pm'
      })

      $('.datepair').datepair()

    # initialitation get days available
    get_days_available: ->
      checkedValues = $('.select_work_day:checked').map( ->
        return this.value
      ).get()
      console.log(checkedValues)
      now = new Date()
      d = new Date()
      d.setMonth(d.getMonth() + 2)
      days_available = []
      while d >= now
        console.log(PHYSIALITY.Steps.getDayName(now))
        if checkedValues.includes(PHYSIALITY.Steps.getDayName(now))
          days_available.push(moment(now).format('MM/DD/YYYY').toString())
        now.setDate(now.getDate() + 1)

      console.log(days_available)
      return(days_available)

    # initialitation get day by name
    getDayName: (dateString) ->
      return ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'][new Date(dateString).getDay()]

    # initialitation for calendar
    initCalendar: (all_dates) ->
      $("#working_calendar").multiDatesPicker({
        minDate: 0,
        numberOfMonths: 2,
        addDates: all_dates,
        onSelect: (dateText, instance) ->
          console.log(dateText)
      })

    getLocation: (wrapperLocation) ->
      wrapperLocation = $(wrapperLocation)
      pullFromAddress = $(wrapperLocation.data('pull-from-address'))
      dataAddress = $(wrapperLocation.data('address')).val()
      dataCity = $(wrapperLocation.data('city')).val()
      dataState = $(wrapperLocation.data('state')).val()
      dataZip = $(wrapperLocation.data('zip')).val()
      dataTarget = wrapperLocation.data('target')
      dataRadius = $(wrapperLocation.data('radius')).val()
      dataSetLatitude = $(wrapperLocation.data('set-latitude'))
      dataSetLongitude = $(wrapperLocation.data('set-longitude'))

      # replace map with loading
      $('#' + dataTarget).html('<div class="map-info">Load Maps</div>')
      if(pullFromAddress.is(':checked'))
        address = dataAddress + ', ' + dataCity + ', ' + dataState + ', ' + dataZip
        console.log(address)
        geocoder = new google.maps.Geocoder();
        geocoder.geocode( { 'address': address}, (results, status) ->
          if (status == google.maps.GeocoderStatus.OK)
            latitude = results[0].geometry.location.lat()
            longitude = results[0].geometry.location.lng()
            PHYSIALITY.Steps.createMap(latitude, longitude, dataTarget, dataRadius, dataSetLatitude, dataSetLongitude)
          else
            $('#' + dataTarget).html('<div class="map-info">GEOCODE FAILED</div>')
          )

      else
        if (navigator.geolocation)
          navigator.geolocation.getCurrentPosition(
            (position) ->
              # success get location
              latitude = position.coords.latitude;
              longitude = position.coords.longitude;
              PHYSIALITY.Steps.createMap(latitude, longitude, dataTarget, dataRadius, dataSetLatitude, dataSetLongitude)

            (error) ->
              # unsuccessfull get location show error
              switch(error.code)
                when error.PERMISSION_DENIED
                  $('#' + dataTarget).html('<div class="map-info">User denied the request for Geolocation</div>')
                  break;
                when error.POSITION_UNAVAILABLE
                  $('#' + dataTarget).html('<div class="map-info">Location information is unavailable</div>')
                  break;
                when error.TIMEOUT
                  $('#' + dataTarget).html('<div class="map-info">The request to get user location timed out</div>')
                  break;
                when error.UNKNOWN_ERROR
                  $('#' + dataTarget).html('<div class="map-info">An unknown error occurred</div>')
                  break;
            )
        else
          $('#' + dataTarget).html('<div class="map-info">Geolocation is not supported by this browser</div>')

    createMap: (latitude, longitude, target, radius, setLatitude, setLongitude) ->
      myLatlng = new google.maps.LatLng(latitude,longitude);
      # remove loading if maps set
      $('#' + target).html("")
      map = new google.maps.Map(document.getElementById(target), {
        center: myLatlng,
        scrollwheel: true,
        zoom: 12,
        zoomControl: true
        })

      marker = new google.maps.Marker({
        position: myLatlng,
        title:"Home"
        })

      setLatitude.val(latitude)
      setLongitude.val(longitude)
      circle = new google.maps.Circle({
        center: myLatlng,
        radius: radius * 1000,
        fillColor: "#ff69b4",
        fillOpacity: 0.5,
        strokeOpacity: 0.0,
        strokeWeight: 0,
        map: map
        })

      marker.setMap(map)

  }
)(jQuery)
