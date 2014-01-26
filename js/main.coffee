
class Main
	defaults:
		transition:    500
		delay: 				 4000
		rainbowTime:   10000
		particleDelay: 0

	constructor:(@o={})->
		@vars()

		@animateRainbow()
		@animate()

	vars:->
		@settings = @extend @defaults, @o

		@percent = 6.9
		@currentProgress = 0

		@rainbow = document.getElementById('rainbow')
		@process = document.getElementById('process')
		@easing  = TWEEN.Easing.Quadratic.In

		@animate 			= @bind @animate, @


	extend:(obj, obj2)->
		for key, value of obj2
			if obj2[key]? then obj[key] = value
		obj

	setProgress:(n)->
		n = @normalizeNum n

	animateRainbow:->
		it = @
		console.log @settings.rainbowTime
		tween = new TWEEN.Tween({ deg: 0 })
			.to({ deg: 360 }, @settings.rainbowTime)
			.onUpdate(->
				it.rainbow.setAttribute 'transform', 'rotate(' + @deg + ', 500, 500)'
			).start().repeat(true)

	normalizeNum:(n)->
		n = n % 101
		@percent * n

	animate:->
		requestAnimationFrame(@animate)
		TWEEN.update()

	bind:(func, context) ->
		wrapper = ->
			args = Array::slice.call(arguments)
			unshiftArgs = bindArgs.concat(args)
			func.apply context, unshiftArgs
		bindArgs = Array::slice.call(arguments, 2)
		wrapper

window.Loading = Main
