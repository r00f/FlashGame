function updateResourceBar(theBar:MovieClip, percent:Number) {
	if (percent >= 0.999) {
		theBar.gotoAndStop("hundert");
	} else if (percent >= 0.9) {
		theBar.gotoAndStop("neun");
	} else if (percent >= 0.8) {
		theBar.gotoAndStop("acht");
	} else if (percent >= 0.7) {
		theBar.gotoAndStop("sieben");
	} else if (percent >= 0.6) {
		theBar.gotoAndStop("sechs");
	} else if (percent >= 0.5) {
		theBar.gotoAndStop("fuenf");
	} else if (percent >= 0.4) {
		theBar.gotoAndStop("vier");
	} else if (percent >= 0.3) {
		theBar.gotoAndStop("drei");
	} else if (percent >= 0.2) {
		theBar.gotoAndStop("zwei");
	} else if (percent >= 0.1) {
		theBar.gotoAndStop("eins");
	} else if (percent >= 0) {
		theBar.gotoAndStop("null");
	}
}
