
class Brain
	constructor: (@title = 'Title', @description = 'Description') ->

	getTemplate: (name) ->
		Ajax = null
		if window.XMLHttpRequest
			Ajax = new XMLHttpRequest()
		else
			Ajax = new ActiveXObject "Microsoft.XMLHTTP"

		if Ajax
			Ajax.open 'get', 'templates/' + name, false
			Ajax.send()
			return Ajax.responseText
		else
			throw 'Ajax not supported'

		false

	about: () ->
		@getTemplate 'about.html'

	nyanCat: () ->
		@getTemplate 'nyan_cat.html'

window.Brain = Brain

$ ->

	brain = new Brain('Nedim Arabacı', 'Hi, this is my term (type help for help) [up|down: history, tab: autocomplete]')

	terminal_cmd = $ '#terminal_cmd'

	terminal_cmd.Termic '#terminal', {
		'__init__': {
			description: 'Term init.',
			handler: () ->
				@.set 'brain', brain
				"#{@.get('brain').title} - #{@.get('brain').description}"
		},
		'about': {
			description: 'About me'
			handler: () ->
				@.get('brain').about()
		},
		'nyan': {
			description: 'Nyan cat'
			handler: (params) ->
				@runCommand 'clear', params
				@.get('brain').nyanCat()
		}
	}

	terminal_cmd.focus()
