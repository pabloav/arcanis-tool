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

function push(pid, url, el) {
	var speed
	speed = prompt("How many ticks?")
	new Ajax.Updater(el, url, { 
		parameters: { "player_id" : pid, "speed" : speed}
	});
}

// This is where we set the serial check interval, FYI.
new PeriodicalExecuter(checkSerial, 3)