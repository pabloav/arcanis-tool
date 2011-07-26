// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
var currentSerial = 0;
var currentClock = 0
function checkSerial() { 
	
	new Ajax.Request('/current', {
		onSuccess: function(response) { 
			obj = response.responseJSON;
			currentClock = obj['clock']
			if (currentSerial != obj['serial']) {
				currentSerial = obj['serial']
				refresh();
			}
		}
	});
}

function refresh() {
	$('refresh').onclick()
}

// This is where we set the serial check interval, FYI.
new PeriodicalExecuter(checkSerial, 1)