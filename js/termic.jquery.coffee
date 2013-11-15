$ = jQuery

$.fn.Termic = (terminal, commands) ->
	$el = $ @
	$terminal = $ terminal

	$el.data 'Termic', Termic::constructer($el[0], $terminal[0], commands)
