// define variables
var nativePicker = document.querySelector('.nativeDatePicker');
var fallbackPicker = document.querySelector('.fallbackDatePicker');

var yearSelect = document.querySelector('[name=year]');
var monthSelect = document.querySelector('[name=month]');

// Test whether a new date input falls back to a text input
var testElement = document.createElement('input');
testElement.type = 'date';

// If it does, run the code inside the if () {} block
if (testElement.type === 'text') {
  // hide the native picker and show the fallback
  nativePicker.hidden = true;
  fallbackPicker.hidden = false;
}