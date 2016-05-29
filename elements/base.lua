local gui = ...
local Element = gui.register("Base")

function Element:Create(Text, x, y, Width, Height, Parent)
	self:SetText(Text)
	self:SetPosition(x, y)
	self:SetDimensions(Width, Height)
	self:SetParent(Parent)
	self:Init()
	
	return self
end

function Element:typeOf(Type)
	if type(Type) == "string" then
		return Type:lower() == "element_"..self.Type:lower()
	end
	return Type == getmetatable(self)
end

function Element:Init()
	self.Children = {}
	self.ChildrenRender = {}
	self.Layout = {}
	
	local Width, Height = self:GetDimensions()
	if Width and Height and Width > 0 and Height > 0 then
		self.Canvas = love.graphics.newCanvas(Width, Height)
	end
	
	local Skin = self:GetSkin()
	if Skin.Init then
		Skin.Init(self)
	end
	self.Changed = true
end

function Element:GetSkin()
	if self.Skin then
		if not self.Base then
			return self.Skin[self.Type]
		end
		return self.Skin[self.Type] or self.Skin[self.Base.Type] or {}
	end
	return {}
end

function Element:OnMousePressed(x, y, Button, IsTouch)
end

function Element:OnMouseReleased(x, y, Button, IsTouch)
end

function Element:OnMouseDrag(x, y, dx, dy)
end

function Element:OnMouseEnter()
end

function Element:OnMouseExit()
end

function Element:OnMouseMoved(x, y, dx, dy)
end

function Element:OnWheelMoved(x, y)
end

function Element:OnKeyPressed(Key, ScanCode, IsRepeat)
end

function Element:OnKeyReleased(Key, ScanCode)
end

function Element:OnTextInput(Text)
end

function Element:MousePressed(x, y, Button, IsTouch)
	self:OnMousePressed(x, y, Button, IsTouch)
	
	local Skin = self:GetSkin()
	if Skin.MousePressed then
		Skin.MousePressed(self, x, y, Button, IsTouch)
	end
end

function Element:MouseReleased(x, y, Button, IsTouch)
	self:OnMouseReleased(x, y, Button, IsTouch)
	
	local Skin = self:GetSkin()
	if Skin.MouseReleased then
		Skin.MouseReleased(self, x, y, Button, IsTouch)
	end
end

function Element:MouseDrag(x, y, dx, dy)
	self:OnMouseDrag(x, y, dx, dy)
end

function Element:MouseEnter()
	self:OnMouseEnter()
	
	local Skin = self:GetSkin()
	if Skin.MouseEnter then
		Skin.MouseEnter(self)
	end
end

function Element:MouseExit()
	self:OnMouseExit()
	
	local Skin = self:GetSkin()
	if Skin.MouseExit then
		Skin.MouseExit(self)
	end
end

function Element:MouseMoved(x, y, dx, dy)
	self:OnMouseMoved(x, y, dx, dy)
	
	local Skin = self:GetSkin()
	if Skin.MouseMoved then
		Skin.MouseMoved(self, x, y, dx, dy)
	end
end

function Element:WheelMoved(x, y)
	self:OnWheelMoved(x, y)
	
	local Skin = self:GetSkin()
	if Skin.WheelMoved then
		Skin.WheelMoved(self, x, y)
	end
end

function Element:KeyPressed(Key, ScanCode, IsRepeat)
	self:OnKeyPressed(Key, ScanCode, IsRepeat)
end

function Element:KeyReleased(Key, ScanCode)
	self:OnKeyReleased(Key, ScanCode)
end

function Element:TextInput(Text)
	self:OnTextInput(Text)
end

function Element:LoadSkin(File)
	local Success, Error = pcall(love.filesystem.load, File)
	if Success then
		local Success, Skin = pcall(Error)
		if Success then
			self.Skin = Skin
			return true
		end
		return false, Skin
	end
	return false, Error
end

function Element:AddChild(Child)
	table.insert(self.ChildrenRender, Child)
	
	local ID = #self.Children + 1
	Child.Parent = self
	Child.ID = ID
	
	if not Child.Skin then
		Child.Skin = self.Skin
	end
	self.Children[ID] = Child
	
	return ID
end

function Element:RemoveChild(Target)
	for Index, Child in pairs(self.Children) do
		if Child == Target then
			self.Parent.Children[Index] = nil
			break
		end
	end
	
	for Index, Child in pairs(self.ChildrenRender) do
		if Child == Target then
			self.Parent.Children[Index] = nil
			break
		end
	end
	
	table.sort(self.Children, function (A, B) return A.ID < B.ID end)
	for Index, Child in pairs(self.Children) do
		Child.ID = Index
	end
end

function Element:SetParent(Parent)
	if self.Parent then
		self.Parent:RemoveChild(self)
	end
	
	if Parent then
		if self.Parent and self.Parent.Skin == self.Skin then
			self.Skin = nil
		end
		Parent:AddChild(self)
	else
		self.Parent = nil
		self.ID = nil
	end
	
	if self.UniqueID then
		gui.Reference[self.UniqueID] = nil
		self.UniqueID = nil
	end
end

function Element:Remove()
	self:SetParent(nil)
end

function Element:SetText(Text)
	if self.Text then
		self.Text:SetText(Text)
	else
		self.Text = gui.CreateText(Text)
	end
	self.Changed = true
	return self
end

function Element:GetText()
	return self.Text:Get()
end

function Element:SetHorizontalPosition(x)
	self.x = x
end

function Element:SetVerticalPosition(y)
	self.y = y
end

function Element:SetPosition(x, y)
	self:SetHorizontalPosition(x)
	self:SetVerticalPosition(y)
end

function Element:GetHorizontalPosition()
	return math.floor(self.x)
end

function Element:GetVerticalPosition()
	return math.floor(self.y)
end

function Element:GetPosition()
	return self:GetHorizontalPosition(), self:GetVerticalPosition()
end

function Element:GetAbsolutePosition()
	if self.Parent then
		local x1, y1 = self:GetPosition()
		local x2, y2 = self.Parent:GetAbsolutePosition()
		return x1 + x2, y1 + y2
	end
	return self:GetPosition()
end

function Element:AdviseChildDimensions(Child, Width, Height)
end

function Element:SetDimensions(Width, Height)
	if Width ~= self.Width or Height ~= self.Height then
		self.Width = Width
		self.Height = Height
		
		local Skin = self:GetSkin()
		if Skin and Skin.SetDimensions then
			Skin.SetDimensions(self, Width, Height)
		end
		
		if self.Canvas then
			self.Canvas = love.graphics.newCanvas(Width, Height)
			self.Changed = true
		end
		
		if self.Parent then
			self.Parent:AdviseChildDimensions(self, Width, Height)
		end
	end
end

function Element:GetWidth()
	return self.Width
end

function Element:GetHeight()
	return self.Height
end

function Element:GetUniqueID()
	return self.UniqueID
end

function Element:GetDimensions()
	return self:GetWidth(), self:GetHeight()
end

function Element:UpdateLayout(dt)
	local Skin = self:GetSkin()
	if Skin.UpdateLayout then
		Skin.UpdateLayout(self, dt, x, y)
	end
end

function Element:Update(dt)
	if self.Changed then
		self:RenderSkin()
		self.Changed = nil
	end
end

function Element:UpdateChildren(dt)
	for _, Child in pairs(self.Children) do
		Child:Update(dt)
		Child:UpdateLayout(dt)
		Child:UpdateChildren(dt)
	end
end

function Element:RenderSkin()
	local Skin = self:GetSkin()
	if Skin.Render then
		love.graphics.setCanvas(self.Canvas)
		love.graphics.clear(0, 0, 0, 0)
		Skin.Render(self)
		love.graphics.setCanvas()
	end
end

function Element:Render(x, y)
	if self.Paint then
		self:Paint(x, y)
	else
		love.graphics.draw(self.Canvas, x, y)
	end
end

function Element:RenderChildrenCanvas()
	for _, Child in pairs(self.ChildrenRender) do
		if not Child.Hidden and Child.Changed then
			Child.Changed = nil
			Child:RenderSkin()
		end
		Child:RenderChildrenCanvas()
	end
end

function Element:RenderChildren(x, y)
	for _, Child in pairs(self.ChildrenRender) do
		if not Child.Hidden then
			local Horizontal, Vertical = Child:GetPosition()
			Child:Render(Horizontal + x, Vertical + y)
			Child:RenderChildren(Horizontal + x, Vertical + y)
		end
	end
end

function Element:SetHover()
	if self.Parent then
		local ChildrenRender = {}
		for _, Child in pairs(self.Parent.ChildrenRender) do
			if Child ~= self then
				table.insert(ChildrenRender, Child)
			end
		end
		table.insert(ChildrenRender, self)
		
		self.Parent.ChildrenRender = ChildrenRender
		self.Parent:SetHover()
	end
end

function Element:MakePopup()
	local Skin = self:GetSkin()
	if Skin.MakePopup then
		Skin.MakePopup(self)
	end
end

function Element:MakePulldown()
	local Skin = self:GetSkin()
	if Skin.MakePulldown then
		Skin.MakePulldown(self)
	end
end

function Element:LocalPointInArea(x, y)
	local Width, Height = self:GetDimensions()
	return x > 0 and y > 0 and x < Width and y < Height
end

function Element:FindMouseHoverChild(x, y)
	if not self.Hidden then
		local Horizontal, Vertical = self:GetPosition()
		local x, y = x - Horizontal, y - Vertical
		
		local Element
		for Index, Child in pairs(self.ChildrenRender) do
			local ChildElement = Child:FindMouseHoverChild(x, y)
			if ChildElement then
				Element = ChildElement
			end
		end
		
		if Element then
			return Element
		elseif self:LocalPointInArea(x, y) then
			return self
		end
	end
end

function Element:FindTopElement()
	if not self.Hidden then
		local Element
		for Index, Child in pairs(self.ChildrenRender) do
			if not Child.Hidden then
				local ChildElement = Child:FindTopElement()
				if ChildElement then
					Element = ChildElement
				end
			end
		end
		
		if Element then
			return Element
		end
		return self
	end
end