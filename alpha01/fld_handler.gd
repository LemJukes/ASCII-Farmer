extends GridContainer

var fld_plot = preload("res://fld_plot.tscn")
var max_plots = 9

func _ready():
	columns = 3
	add_plot()

func add_plot():
	if get_child_count() >= max_plots:
		print("Max Plots")
		return false
	else:
		var new_plot = fld_plot.instantiate()
		add_child(new_plot)
		return true
