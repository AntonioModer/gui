local gui = ...
local Element = gui.register("Graph", "Element")

function Element:Create(x, y, Width, Height, Parent)
	Parent = Parent or gui.Desktop

	self.Curve = {}
	self:SetParent(Parent)
	self:SetPosition(x, y)
	self:SetDimensions(Width, Height)
	self:Init()
	
	return self
end

function Element:AddCurve(BezierCurve, R, G, B, A)
	if type(BezierCurve) == "userdata" and BezierCurve:typeOf("BezierCurve") then
		local Curve = {}
		Curve.BezierCurve = BezierCurve
		Curve.Color = {R, G, B, A}
		
		table.insert(self.Curve, Curve)
	end
end

function Element:UpdateGraph()
	self.Changed = true
end