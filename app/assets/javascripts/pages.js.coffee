jQuery ->
	$('#stationName').autocomplete
		source: $('#stationName').data('autocomplete-source')