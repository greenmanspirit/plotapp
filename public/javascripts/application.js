// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {
	$("#plotpoints").sortable({
		handle:	'.smallIndexCardTop',
		opacity: 0.7,
		revert: true,
		tolerance: 'pointer',
		update: function(event, ui) {
				$.ajax({
					type: "POST",
					url: "plotpoints/sort",
					data: $('#plotpoints').sortable("serialize"),
				})
			}
	});
	$('#settingIndexCards').accordion({
		collapsible: true,
		active:	'.lastSettingIndexCard'
	});
	$('#addVirtueLink').click(function() {
		var num  = $('.virtue').length;
		$('#virtueList').append(newCharFormElement(num, 'virtue'));
		return false;
	});
	$('#addViceLink').click(function() {
		var num  = $('.vice').length;
		$('#viceList').append(newCharFormElement(num, 'vice'));
		return false;
	});
	$('#addHabitLink').click(function() {
		var num  = $('.habit').length;
		$('#habitList').append(newCharFormElement(num, 'habit'));
		return false;
	});
});
function newCharFormElement(idNum, charAttribute) {
	var pluralAttr = charAttribute+'s';
	var arrayRef = 'character['+pluralAttr+'_attributes]['+idNum+']';
	var attrStr = 'character_'+pluralAttr+'_attributes_'+idNum+'_';
	var li = $('<li></li>');
	var deleteCheckboxHidden = $('<input>').attr('type','hidden').attr('name',arrayRef+'[_destroy]').attr('value',0);
	var deleteCheckbox = $('<input>').attr('type','checkbox').attr('name',arrayRef+'[_destroy]').attr('value',1).attr('id',attrStr+'_destroy');
	var textHidden = $('<input>').attr('type','hidden').attr('name',arrayRef+'[id]').attr('id',attrStr+'id');
	var text = $('<input>').attr('type','text').attr('name',arrayRef+'[detail]').attr('id',attrStr+'detail').addClass(charAttribute).attr('size',30);
	return li.append(deleteCheckboxHidden).append(deleteCheckbox).append(textHidden).append(text);
}
