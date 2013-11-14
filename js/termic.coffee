class Termic

	constructer: (@el, @terminal, @commands = {}) ->
		@_storage = {}
		@_history = []
		@_history_index = -1

		@addCommand('help', 'List of available commands', (params) ->
			list = for cmd_name, cmd of @commands
				if cmd_name != '__init__'
					"#{cmd_name} \t\t #{cmd.description}"
				else

			"Available commands: \n#{list.join("\n")}"
		)

		@addCommand('clear', 'Clears the screen', () ->
			@terminal.innerHTML = ''
			@runCommand '__init__', []
		)

		@listen()
		@init()
		this

	init: ->
		@appendToTerminal @createFormat "termic-entry", @commands['__init__'].handler?.call(@)

	listen: ->
		@el.addEventListener 'keydown', (e) =>
			key = if e.which then e.which else e.keyCode
			if key == 13 #enter
				@handleCommand()
				return false
			else if key == 9 #tab
				e.preventDefault()
				@handleTab()
				return false
			else if key == 38 #up
				e.preventDefault()
				@handleHistory('up')
				return false
			else if key == 40 #down
				e.preventDefault()
				@handleHistory('down')
				return false

	addCommand: (name, description, handler) ->
		if @commands[name]
			console.info '#{command} already attached'
		else
			@commands[name] = {
				description: description
				handler: handler
			}
		this

	handleHistory: (direction) ->
		@calculateHistoryIndex(direction)
		@el.value = if @_history[@_history_index] then @_history[@_history_index] else ''

	calculateHistoryIndex: (direction) ->
		switch direction
			when 'up'
				@_history_index += 1
				if @_history_index > @_history.length - 1
					@_history_index = 0
			when 'down'
				@_history_index -= 1
				if @_history_index < 0
					@_history_index = @_history.length - 1

	handleCommand: () ->
		input = @el.value
		input_pieces = input.split ' '
		command = input_pieces.shift()
		params = input_pieces

		@appendToTerminal @createFormat "termic-command", "> #{input}"

		# clear the command input value
		@el.value = ''

		# try to run this command with params
		@runCommand(command, params)

	handleTab: () ->
		input = @el.value
		regex = new RegExp "^#{input}", "gi"
		list = for cmd_name, cmd of @commands
			if (cmd_name.match regex) and (cmd_name != '__init__')
				cmd_name
			else

		if list.length == 1
			@el.value = "#{list[0]} "
		else if list.length > 1
			@appendToTerminal @createFormat 'termic-suggestions', "Suggestions: #{list.join(', ')}"

	runCommand: (command, params) ->
		@_history.splice 0, 0, "#{command} #{params.join(' ')}"
		@_history_index = -1

		if @commands[command]
			@appendToTerminal @createFormat "termic-entry", @commands[command].handler?.call(@, params)
		else
			@appendToTerminal @createFormat "termic-error", "&laquo;#{command}&raquo; command not found."

	appendToTerminal: (message) ->
		@terminal.innerHTML = "#{@terminal.innerHTML} #{message}"
		window.scrollTo? 0, @terminal.scrollHeight

	createFormat: (cls, message) ->
		if (message)
			Container = document.createElement('div');
			Message = document.createElement('div');
			Message.className = cls
			Message.innerHTML = message
			Container.appendChild Message
			Container.innerHTML
		else
			''

	set: (key, value) ->
		@_storage[key] = value

	get: (key) ->
		@_storage[key]

window.Termic = Termic
