local Path, gui = ...

return {
	Button = love.filesystem.load(Path.."button.lua")(Path, gui),
	CheckBox = love.filesystem.load(Path.."checkbox.lua")(Path, gui),
	CollapsibleCategory = love.filesystem.load(Path.."collapsiblecategory.lua")(Path, gui),
	CollapsibleNode = love.filesystem.load(Path.."collapsiblenode.lua")(Path, gui),
	ComboBox = love.filesystem.load(Path.."combobox.lua")(Path, gui),
	Console = love.filesystem.load(Path.."console.lua")(Path, gui),
	Graph = love.filesystem.load(Path.."graph.lua")(Path, gui),
	HSlider = love.filesystem.load(Path.."hslider.lua")(Path, gui),
	Label = love.filesystem.load(Path.."label.lua")(Path, gui),
	ListBox = love.filesystem.load(Path.."listbox.lua")(Path, gui),
	ProgressBar = love.filesystem.load(Path.."progressbar.lua")(Path, gui),
	Tabber = love.filesystem.load(Path.."tabber.lua")(Path, gui),
	TextArea = love.filesystem.load(Path.."textarea.lua")(Path, gui),
	TextField = love.filesystem.load(Path.."textfield.lua")(Path, gui),
	VSlider = love.filesystem.load(Path.."vslider.lua")(Path, gui),
	Window = love.filesystem.load(Path.."window.lua")(Path, gui),
}