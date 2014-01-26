
class Main
	defaults:
		transition:    1500
		delay: 				 4000
		rainbowTime:   30000
		particleDelay: 0

	constructor:(@o={})->
		@vars()

		@animateRainbow()
		@animate()

	vars:->
		@settings = @extend @defaults, @o

		@currentProgress = 2000

		@rainbow = document.getElementById('rainbow')
		@process = document.getElementById('js-process')
		@easing  = TWEEN.Easing.Quadratic.In

		@animate 			= @bind @animate, @


	extend:(obj, obj2)->
		for key, value of obj2
			if obj2[key]? then obj[key] = value
		obj

	setProgress:(n)->
		n = @normalizeNum n
		it = @
		tween = new TWEEN.Tween({ p: @currentProgress })
			.to({ p: n }, @settings.transition)
			.onUpdate(->
				it.process.setAttribute 'stroke-dashoffset', @p
				it.currentProgress = @p
			).start()


	animateRainbow:->
		it = @
		tween = new TWEEN.Tween({ deg: 0 })
			.to({ deg: 360 }, @settings.rainbowTime)
			.onUpdate(->
				it.rainbow.setAttribute 'transform', 'rotate(' + @deg + ', 500, 500)'
			).start().repeat(9999999999999999)

	normalizeNum:(n)->
		n = n % 101
		n = n/100
		n *= 2000
		n = 2000 - n

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
