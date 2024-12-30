extends GridContainer

var fld_plot = preload("res://fld_plot.tscn")
var max_plots = 9

func _ready():
	pass
	
func _add_first_plot():
	var first_plot = fld_plot.instantiate()
	add_child(first_plot)

func check_plot_count() -> bool:
	if get_child_count() >= max_plots:
		print("Can't add any more plots, the field is full!")
		return false
	else:
		print("A plot can be added...")
		return true

func add_plot():
	var new_plot = fld_plot.instantiate()
	add_child(new_plot)
	var plot_count = get_child_count()
	print("Plot Added!")
	print("There are currently: " + str(plot_count) + " plots in the Field.")
	return true
