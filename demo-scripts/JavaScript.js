/**
 * JavaScript: I love pitaya
 * @param String hello Hello.
 * @since 1.0.0
 */

// String.
const pst = '🦄 This is pitaya smoothie.';
console.log('pst', pst);

// Class.
class vsc extends React.Component { }
console.log(vsc);

// Const.
const tania = function nameTania() {
	return 'Tania';
};
tania();

// Let.
let allard = () => 'Allard';
console.log(allard);


// Regex.
const coursePlatformURL = new RegExp('/' + window.location.host + '/');
console.log('coursePlatformURL', coursePlatformURL);

import { btnBarSvgSpeed } from './constants';

/**
 *  Angle increment.§
 *
 * — 360/(total speed values).
 * — 360/6 = 60.
 */
export const speedAngles = {
	'1': '0',
	'1.25': '60',
	'1.5': '120',
	'1.75': '180',
	'2': '240',
	'0.75': '300'
};

/**
 * Speed SVG CSS.
 *
 * @param Number one Angle to rotate the SVG.
 * @param Number two Angle to rotate the SVG.
 * @param Number three Angle to rotate the SVG.
 */
export const speedCSS = (one, two, three) => {
	btnBarSvgSpeed.css({
		transform: `rotate(${one}deg)`,
		transform: `rotate(${two}deg)`,
		transform: `rotate(${three}deg)`
	});
};

// Conditionals.
if (tania) {
	console.log('Tania loves open source');
} else if (allard) {
	console.log('Allard is making pitaya smoothie');
} else {
	console.log('Call it pst for brevity');
}
