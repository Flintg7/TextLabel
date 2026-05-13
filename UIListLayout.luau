local ReplicatedStorage = game:GetService("ReplicatedStorage")

local vide = require(ReplicatedStorage.Packages.vide)
local create = vide.create

type Props = {
	Padding: UDim?,
	FillDirection: "Vertical" | "Horizontal"?,
	HorizontalAlignment: "Left" | "Center" | "Right"?,
	VerticalAlignment: "Top" | "Center" | "Bottom"?,
	SortOrder: "LayoutOrder" | "Name"?,
	Wraps: boolean?,
	Spacing: number?,
}

return function(props: Props)
	local fillDirection = if props.FillDirection == "Horizontal"
		then Enum.FillDirection.Horizontal
		else Enum.FillDirection.Vertical

	local horizontalAlignment = if props.HorizontalAlignment == "Center"
		then Enum.HorizontalAlignment.Center
		elseif props.HorizontalAlignment == "Right" then Enum.HorizontalAlignment.Right
		else Enum.HorizontalAlignment.Left

	local verticalAlignment = if props.VerticalAlignment == "Center"
		then Enum.VerticalAlignment.Center
		elseif props.VerticalAlignment == "Bottom" then Enum.VerticalAlignment.Bottom
		else Enum.VerticalAlignment.Top

	local sortOrder = if props.SortOrder == "Name" then Enum.SortOrder.Name else Enum.SortOrder.LayoutOrder

	return create("UIListLayout", {
		Padding = props.Padding or UDim.new(0, 0),
		FillDirection = fillDirection,

		HorizontalAlignment = horizontalAlignment,
		VerticalAlignment = verticalAlignment,

		SortOrder = sortOrder,
		Wraps = props.Wraps or false,
	})
end
