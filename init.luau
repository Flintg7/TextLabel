--!nocheck
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local UIListLayout = require(script.Parent.UIListLayout)
local UIStroke = require(script.Parent.UIStroke)
local vide = require(ReplicatedStorage.Packages.vide)

local create = vide.create

type Props = {
	Name: string?,
	Text: string?,
	Position: UDim2?,
	Size: UDim2?,
	TextColor3: Color3?,
	StrokeThickness: number?,
	StrokeColor: Color3?,
	ZIndex: number?,
	BackgroundTransparency: number,
	TextXAlignment: Enum.TextXAlignment?,
	Children: { Instance? },
	Prefix: {
		Image: string?,
		ImageScale: number?,
		PrefixLayoutDirection: "Center" | "Left" | "Right",
		Size: UDim2?,
		Padding: UDim?,
	},
	AutomaticSize: Enum.AutomaticSize?,
	DropShadow: {
		Offset: UDim2?,
		Color: Color3?,
		Transparency: number?,
	}?,
	action: (Instance) -> any,
	AnchorPoint: Vector2?,
}

local function renderLabel(props: Props)
	return create("TextLabel", {
		BackgroundTransparency = props.BackgroundTransparency or 1,
		AnchorPoint = function()
			if props.Prefix and props.DropShadow then
				return Vector2.new(0, 0)
			else
				return Vector2.new(0.5, 0.5)
			end
		end,
		TextScaled = true,
		Font = Enum.Font.BuilderSansExtraBold,

		Text = props.Text or "Label",
		Position = function()
			if props.Prefix and props.DropShadow then
				return UDim2.fromScale(0, 0)
			else
				return UDim2.fromScale(0.5, 0.5)
			end
		end,
		Size = function()
			if props.Prefix then
				return UDim2.fromScale(0, 1)
			else
				return UDim2.fromScale(1, 1)
			end
		end,

		TextColor3 = props.TextColor3 or Color3.new(1, 1, 1),
		ZIndex = props.ZIndex or 1,
		TextXAlignment = props.TextXAlignment or Enum.TextXAlignment.Center,
		AutomaticSize = function()
			if props.Prefix then
				return Enum.AutomaticSize.X
			elseif props.DropShadow then
				return Enum.AutomaticSize.X
			else
				return Enum.AutomaticSize.None
			end
		end,

		UIStroke({
			Thickness = props.StrokeThickness or 0,
			Color = props.StrokeColor or Color3.new(0, 0, 0),
		}),

		props.Children,
	})
end
local function renderShadow(props: Props)
	local shadowZIndex = if props.ZIndex then props.ZIndex - 1 else 0

	return create("TextLabel", {
		BackgroundTransparency = 1,
		AnchorPoint = props.AnchorPoint or Vector2.new(0, 0),
		TextScaled = true,
		Font = Enum.Font.BuilderSansExtraBold,

		Text = props.Text or "Label",

		Position = props.Position + props.DropShadow.Offset or UDim2.new(),

		Size = UDim2.fromScale(1, 1),
		TextColor3 = props.DropShadow.Color or Color3.new(0, 0, 0),
		ZIndex = shadowZIndex,
		TextXAlignment = props.TextXAlignment or Enum.TextXAlignment.Center,
		TextTransparency = props.DropShadow.Transparency or 0,

		AutomaticSize = if props.Prefix then Enum.AutomaticSize.X else Enum.AutomaticSize.None,
	})
end
return function(props: Props)
	local dropShadow
	local prefixIcon
	local prefixUIListLayout

	if props.DropShadow and props.Prefix == nil then
		dropShadow = renderShadow(props)
	end
	if props.Prefix then
		prefixIcon = create("ImageLabel", {
			Size = props.Prefix.Size or UDim2.new(0.5, 0, 0.5, 0),
			LayoutOrder = -1,
			BackgroundTransparency = 1,
			Image = props.Prefix.Image,
			ScaleType = Enum.ScaleType.Fit,

			create("UIScale", {
				Scale = props.Prefix.ImageScale or 1,
			}),
		})

		prefixUIListLayout = UIListLayout({
			FillDirection = "Horizontal",
			Padding = props.Prefix.Padding or UDim.new(0, 3),
			HorizontalAlignment = props.Prefix.PrefixLayoutDirection or "Center",
			VerticalAlignment = "Center",
		})
	end

	local textContainer
	textContainer = renderLabel(props)

	return create("Frame", {
		Name = props.Name or "",
		Size = props.Size or UDim2.fromScale(1, 1),
		Position = props.Position or UDim2.fromScale(0.5, 0.5),
		AnchorPoint = props.AnchorPoint or Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,

		prefixIcon,
		prefixUIListLayout,
		textContainer,
		dropShadow,
	})
end
