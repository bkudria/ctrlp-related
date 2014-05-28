ctrlp-related
=============

A Vim plugin for listing related file based on the current buffer's filename.

For example, you have the following file structure:

```
...
app 
	- models
		- user.js
		- recipe.js
		...
	- views
		- user.js
		- recipe.js
		...
	- controllers
		- user.js
		- recipe.js
		...
...
```

If the current buffer is `app/models/recipe.js`, after trigger the `ctrlp-related` you will see the following:

 - `app/views/recipe.js`
 - `app/controllers/recipe.js`

## Configurations

`Leader-s` to activate the plugin

## Requirements

 - [Vundle](https://github.com/gmarik/Vundle.vim)
	
