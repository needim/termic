$ = jQuery

$.fn.Termic = (terminal, commands) ->
	$el = $ @
	$terminal = $ terminal

	Termic::constructer($el[0], $terminal[0], commands)
