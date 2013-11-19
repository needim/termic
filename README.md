# [Termic](http://github.com/needim/termic)

Termic is an idea for personal pages and terminal lovers! <3

* Source: [https://github.com/needim/termic](https://github.com/needim/termic)
* Homepage & Demo: [http://needim.github.io/termic](http://needim.github.io/termic)

## GitHub & Contributing
This is opensource, so feel free to fork this project and create a terminal for your own use. All source code is developed with CoffeeScript, so you can quickly get to make your own modifications in it.
And feel free for sending pull requests.

## Quick start

``` html
<link rel="stylesheet" href="css/termic.css">
<script src="js/termic.js"></script>
<script src="js/termic.jquery.js"></script> <!-- This is a jQuery adapter for using with jQuery -->
```

### Example HTML Structure for Terminal
``` html
<div id="container">
	<div id="terminal_container">
		<pre id="terminal"></pre>
	</div>

	<div id="terminal_input_container">
		<div id="terminal_input_wrap">
			<input id="terminal_cmd" type="text">
		</div>
	</div>
</div>
```

### Initialize the Termic
``` coffeescript
window.terminal_cmd = $ '#terminal_cmd'

terminal_cmd.Termic '#terminal', {
	'__init__': {
		description: 'Term init.',
		handler: () ->
			"Terminal initialized!"
	},
	'about': {
		description: 'About me'
		handler: () ->
			"Some text about you"
	},
	'test': {
		description: 'Basic test command just prints the params'
		handler: (params) ->
			params.join ", "
	}
}
```

## Features

* You can add commands easily.
* Terminal has a default "help" command for listing available commands and "clear" for the clean screen.
* If you want, you can able to create a blog with Termic.
* It's limited with your imagination.